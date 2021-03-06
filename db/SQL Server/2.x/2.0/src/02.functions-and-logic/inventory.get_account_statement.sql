﻿IF OBJECT_ID('inventory.get_account_statement') IS NOT NULL
DROP FUNCTION inventory.get_account_statement;

GO

CREATE FUNCTION inventory.get_account_statement
(
    @value_date_from        date,
    @value_date_to          date,
    @user_id                integer,
    @item_id                integer,
    @store_id               integer
)
RETURNS @result TABLE
(
    id                      integer,
    value_date              date,
    book_date               date,
    tran_code national character varying(50),
    statement_reference     national character varying(2000),
    debit                   numeric(30, 6),
    credit                  numeric(30, 6),
    balance                 numeric(30, 6),
    book                    national character varying(50),
    item_id                 integer,
    item_code national character varying(50),
    item_name               national character varying(1000),
    posted_on               DATETIMEOFFSET,
    posted_by               national character varying(1000),
    approved_by             national character varying(1000),
    verification_status     integer
)
AS
BEGIN
    INSERT INTO @result(value_date, statement_reference, debit, item_id)
    SELECT 
        @value_date_from, 
        'Opening Balance',
        SUM
        (
            CASE inventory.checkout_details.transaction_type
            WHEN 'Dr' THEN base_quantity
            ELSE base_quantity * -1 
            END            
        ) as debit,
        @item_id
    FROM inventory.checkout_details
    INNER JOIN inventory.checkouts
    ON inventory.checkout_details.checkout_id = inventory.checkouts.checkout_id
    INNER JOIN finance.transaction_master
    ON inventory.checkouts.transaction_master_id = finance.transaction_master.transaction_master_id
    WHERE finance.transaction_master.verification_status_id > 0
    AND finance.transaction_master.value_date < @value_date_from
    AND inventory.checkout_details.store_id = @store_id
    AND inventory.checkout_details.item_id = @item_id;

    DELETE FROM @result
    WHERE COALESCE(debit, 0) = 0
    AND COALESCE(credit, 0) = 0;

    UPDATE @result SET 
    debit = credit * -1,
    credit = 0
    WHERE credit < 0;

    INSERT INTO @result(value_date, book_date, tran_code, statement_reference, debit, credit, book, item_id, posted_on, posted_by, approved_by, verification_status)
    SELECT
        finance.transaction_master.value_date,
        finance.transaction_master.book_date,
        finance.transaction_master.transaction_code,
        finance.transaction_master.statement_reference,
        CASE inventory.checkout_details.transaction_type
        WHEN 'Dr' THEN base_quantity
        ELSE 0 END AS debit,
        CASE inventory.checkout_details.transaction_type
        WHEN 'Cr' THEN base_quantity
        ELSE 0 END AS credit,
        finance.transaction_master.book,
        inventory.checkout_details.item_id,
        finance.transaction_master.transaction_ts AS posted_on,
        account.get_name_by_user_id(finance.transaction_master.user_id),
        account.get_name_by_user_id(finance.transaction_master.verified_by_user_id),
        finance.transaction_master.verification_status_id
    FROM finance.transaction_master
    INNER JOIN inventory.checkouts
    ON finance.transaction_master.transaction_master_id = inventory.checkouts.transaction_master_Id
    INNER JOIN inventory.checkout_details
    ON inventory.checkouts.checkout_id = inventory.checkout_details.checkout_id
    WHERE finance.transaction_master.verification_status_id > 0
    AND finance.transaction_master.value_date >= @value_date_from
    AND finance.transaction_master.value_date <= @value_date_to
    AND inventory.checkout_details.store_id = @store_id 
    AND inventory.checkout_details.item_id = @item_id
    ORDER BY 
        finance.transaction_master.value_date,
        finance.transaction_master.last_verified_on;
    
    UPDATE @result
    SET balance = c.balance
    FROM
    (
        SELECT
            temp_account_statement.id, 
            SUM(COALESCE(c.debit, 0)) 
            - 
            SUM(COALESCE(c.credit,0)) As balance
        FROM @result AS temp_account_statement
        LEFT JOIN temp_account_statement AS c 
            ON (c.id <= temp_account_statement.id)
        GROUP BY temp_account_statement.id
    ) AS c
    WHERE id = c.id;

    UPDATE @result 
    SET
        item_code = inventory.items.item_code,
        item_name = inventory.items.item_name
    FROM @result AS result 
    INNER JOIN inventory.items
    ON result.item_id = inventory.items.item_id;

    RETURN;        
END;





--SELECT * FROM inventory.get_account_statement('1-1-2010', '1-1-2020', 2, 1, 1);




GO

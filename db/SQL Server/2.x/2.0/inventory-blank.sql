﻿-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/01.types-domains-tables-and-constraints/tables-and-constraints.sql --<--<--
EXECUTE dbo.drop_schema 'inventory';
GO
CREATE SCHEMA inventory;
GO


--TODO: CREATE UNIQUE INDEXES

CREATE TABLE inventory.units
(
    unit_id                                 integer IDENTITY PRIMARY KEY,
    unit_code                               national character varying(24) NOT NULL,
    unit_name                               national character varying(500) NOT NULL,    
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE TABLE inventory.compound_units
(
    compound_unit_id                        integer IDENTITY PRIMARY KEY,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    value                                   smallint NOT NULL DEFAULT(0) CHECk(value > 0),
    compare_unit_id                         integer NOT NULL REFERENCES inventory.units,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)
);


CREATE TABLE inventory.supplier_types
(
    supplier_type_id                        integer IDENTITY PRIMARY KEY,
    supplier_type_code                      national character varying(24) NOT NULL,
    supplier_type_name                      national character varying(500) NOT NULL,
    account_id                                integer NOT NULL REFERENCES finance.accounts,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE TABLE inventory.suppliers
(
    supplier_id                             integer IDENTITY PRIMARY KEY,
    supplier_code                           national character varying(24) NOT NULL,
    supplier_name                           national character varying(500) NOT NULL,
    supplier_type_id                        integer NOT NULL REFERENCES inventory.supplier_types,
    account_id                                integer NOT NULL REFERENCES finance.accounts,
    currency_code                            national character varying(12) NOT NULL REFERENCES core.currencies,
    company_name                            national character varying(1000),
    company_address_line_1                  national character varying(128),   
    company_address_line_2                  national character varying(128),
    company_street                          national character varying(1000),
    company_city                            national character varying(1000),
    company_state                           national character varying(1000),
    company_country                         national character varying(1000),
    company_po_box                          national character varying(1000),
    company_zipcode                         national character varying(1000),
    company_phone_numbers                   national character varying(1000),
    company_fax                             national character varying(100),
    logo                                    dbo.photo,
    contact_first_name                      national character varying(100),
    contact_middle_name                     national character varying(100),
    contact_last_name                       national character varying(100),
    contact_address_line_1                  national character varying(128),   
    contact_address_line_2                  national character varying(128),
    contact_street                          national character varying(100),
    contact_city                            national character varying(100),
    contact_state                           national character varying(100),
    contact_country                         national character varying(100),
    contact_po_box                          national character varying(100),
    contact_zipcode                         national character varying(100),
    contact_phone_numbers                   national character varying(100),
    contact_fax                             national character varying(100),
    photo                                   dbo.photo,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)
);


CREATE TABLE inventory.customer_types
(
    customer_type_id                        integer IDENTITY PRIMARY KEY,
    customer_type_code                      national character varying(24) NOT NULL,
    customer_type_name                      national character varying(500) NOT NULL,
    account_id                                integer NOT NULL REFERENCES finance.accounts,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)
);


CREATE TABLE inventory.customers
(
    customer_id                             integer IDENTITY PRIMARY KEY,
    customer_code                           national character varying(24) NOT NULL,
    customer_name                           national character varying(500) NOT NULL,
    customer_type_id                        integer NOT NULL REFERENCES inventory.customer_types,
    account_id                                integer NOT NULL REFERENCES finance.accounts,
    currency_code                            national character varying(12) NOT NULL REFERENCES core.currencies,
    company_name                            national character varying(1000),
    company_address_line_1                  national character varying(128),   
    company_address_line_2                  national character varying(128),
    company_street                          national character varying(1000),
    company_city                            national character varying(1000),
    company_state                           national character varying(1000),
    company_country                         national character varying(1000),
    company_po_box                          national character varying(1000),
    company_zipcode                         national character varying(1000),
    company_phone_numbers                   national character varying(1000),
    company_fax                             national character varying(100),
    logo                                    dbo.photo,
    contact_first_name                      national character varying(100),
    contact_middle_name                     national character varying(100),
    contact_last_name                       national character varying(100),
    contact_address_line_1                  national character varying(128),   
    contact_address_line_2                  national character varying(128),
    contact_street                          national character varying(100),
    contact_city                            national character varying(100),
    contact_state                           national character varying(100),
    contact_country                         national character varying(100),
    contact_po_box                          national character varying(100),
    contact_zipcode                         national character varying(100),
    contact_phone_numbers                   national character varying(100),
    contact_fax                             national character varying(100),
    photo                                   dbo.photo,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE TABLE inventory.item_groups
(
    item_group_id                           integer IDENTITY PRIMARY KEY,
    item_group_code                         national character varying(24) NOT NULL,
    item_group_name                         national character varying(500) NOT NULL,
    exclude_from_purchase                   bit NOT NULL DEFAULT(0),
    exclude_from_sales                      bit NOT NULL DEFAULT(0),    
    sales_account_id                        integer NOT NULL REFERENCES finance.accounts,
    sales_discount_account_id               integer NOT NULL REFERENCES finance.accounts,
    sales_return_account_id                 integer NOT NULL REFERENCES finance.accounts,
    purchase_account_id                     integer NOT NULL REFERENCES finance.accounts,
    purchase_discount_account_id            integer NOT NULL REFERENCES finance.accounts,
    inventory_account_id                    integer NOT NULL REFERENCES finance.accounts,
    cost_of_goods_sold_account_id           integer NOT NULL REFERENCES finance.accounts,    
    parent_item_group_id                    integer REFERENCES inventory.item_groups(item_group_id),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)    
);

CREATE TABLE inventory.brands
(
    brand_id                                integer IDENTITY PRIMARY KEY,
    brand_code                              national character varying(24) NOT NULL,
    brand_name                              national character varying(500) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)    
);

CREATE TABLE inventory.item_types
(
    item_type_id                            integer IDENTITY PRIMARY KEY,
    item_type_code                          national character varying(12) NOT NULL,
    item_type_name                          national character varying(50) NOT NULL,
    is_component                            bit NOT NULL DEFAULT(0),
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)    
);

CREATE UNIQUE INDEX item_type_item_type_code_uix
ON inventory.item_types(item_type_code);


CREATE UNIQUE INDEX item_type_item_type_name_uix
ON inventory.item_types(item_type_name);


CREATE TABLE inventory.items
(
    item_id                                 integer IDENTITY PRIMARY KEY,
    item_code                               national character varying(24) NOT NULL,
    item_name                               national character varying(500) NOT NULL,
    barcode                                 national character varying(100), --UNIQUE
    item_group_id                           integer NOT NULL REFERENCES inventory.item_groups,
    item_type_id                            integer NOT NULL REFERENCES inventory.item_types,
    brand_id                                integer REFERENCES inventory.brands,
    preferred_supplier_id                   integer REFERENCES inventory.suppliers,
    lead_time_in_days                       integer,
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    hot_item                                bit NOT NULL DEFAULT(0),
    is_taxable_item                         bit NOT NULL DEFAULT(1),
    cost_price                              decimal(30, 6),
    cost_price_includes_tax                 bit NOT NULL DEFAULT(0),
    selling_price                           decimal(30, 6),
    selling_price_includes_tax              bit NOT NULL DEFAULT(0),
    reorder_level                           integer NOT NULL DEFAULT(0),
    reorder_quantity                        decimal(30, 6) NOT NULL DEFAULT(0),
    reorder_unit_id                         integer NOT NULL REFERENCES inventory.units,
    maintain_inventory                      bit NOT NULL DEFAULT(1),
    photo                                   dbo.photo,
    allow_sales                             bit NOT NULL DEFAULT(1),
    allow_purchase                          bit NOT NULL DEFAULT(1),
    is_variant_of                           integer REFERENCES inventory.items,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                 bit DEFAULT(0)    
);


CREATE TABLE inventory.store_types
(
    store_type_id                           integer IDENTITY PRIMARY KEY,
    store_type_code                         national character varying(12) NOT NULL,
    store_type_name                         national character varying(50) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)    
);

CREATE TABLE inventory.stores
(
    store_id                                integer IDENTITY PRIMARY KEY,
    store_code                              national character varying(24) NOT NULL,
    store_name                              national character varying(100) NOT NULL,
    store_type_id                           integer NOT NULL REFERENCES inventory.store_types,
    office_id                                integer NOT NULL REFERENCES core.offices,
    default_account_id_for_checks           integer NOT NULL REFERENCES finance.accounts,
    default_cash_account_id                 integer NOT NULL REFERENCES finance.accounts,
    default_cash_repository_id              integer NOT NULL REFERENCES finance.cash_repositories,
    address_line_1                          national character varying(128),   
    address_line_2                          national character varying(128),
    street                                  national character varying(50),
    city                                    national character varying(50),
    state                                   national character varying(50),
    country                                 national character varying(50),
    phone                                   national character varying(50),
    fax                                     national character varying(50),
    cell                                    national character varying(50),
    allow_sales                             bit NOT NULL DEFAULT(1),    
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)    
);

CREATE TABLE inventory.counters
(
    counter_id                              integer IDENTITY PRIMARY KEY,
    counter_code                            national character varying(12) NOT NULL,
    counter_name                            national character varying(100) NOT NULL,
    store_id                                integer NOT NULL REFERENCES inventory.stores,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE TABLE inventory.shippers
(
    shipper_id                              integer IDENTITY PRIMARY KEY,
    shipper_code                            national character varying(24),
    company_name                            national character varying(128) NOT NULL,
    shipper_name                            national character varying(150),
    po_box                                  national character varying(128),
    address_line_1                          national character varying(128),   
    address_line_2                          national character varying(128),
    street                                  national character varying(50),
    city                                    national character varying(50),
    state                                   national character varying(50),
    country                                 national character varying(50),
    phone                                   national character varying(50),
    fax                                     national character varying(50),
    cell                                    national character varying(50),
    email                                   national character varying(128),
    url                                     national character varying(50),
    contact_person                          national character varying(50),
    contact_po_box                          national character varying(128),
    contact_address_line_1                  national character varying(128),   
    contact_address_line_2                  national character varying(128),
    contact_street                          national character varying(50),
    contact_city                            national character varying(50),
    contact_state                           national character varying(50),
    contact_country                         national character varying(50),
    contact_email                           national character varying(128),
    contact_phone                           national character varying(50),
    contact_cell                            national character varying(50),
    factory_address                         national character varying(250),
    pan_number                              national character varying(50),
    sst_number                              national character varying(50),
    cst_number                              national character varying(50),
    account_id                              integer NOT NULL REFERENCES finance.accounts(account_id),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)
);


CREATE TABLE inventory.checkouts
(
    checkout_id                             bigint IDENTITY PRIMARY KEY,
    value_date                                date NOT NULL,
    book_date                                date NOT NULL,
    transaction_master_id                    bigint NOT NULL REFERENCES finance.transaction_master,
    transaction_timestamp                   DATETIMEOFFSET NOT NULL DEFAULT(GETDATE()),
    transaction_book                        national character varying(100) NOT NULL, --SALES, PURCHASE, INVENTORY TRANSFER, DAMAGE
    discount                                decimal(30, 6) DEFAULT(0),
    posted_by                               integer NOT NULL REFERENCES account.users,
    /*LOOKUP FIELDS, ONLY TO SPEED UP THE QUERY */
    office_id                               integer NOT NULL REFERENCES core.offices,
    /*LOOKUP FIELDS */    
    cancelled                               bit NOT NULL DEFAULT(0),
    cancellation_reason                        national character varying(1000),
    shipper_id                                integer REFERENCES inventory.shippers,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)    
);


CREATE TABLE inventory.checkout_details
(
    checkout_detail_id                      bigint IDENTITY PRIMARY KEY,
    checkout_id                             bigint NOT NULL REFERENCES inventory.checkouts,
    store_id                                integer NOT NULL REFERENCES inventory.stores,
    value_date                                date NOT NULL,
    book_date                                date NOT NULL,
    transaction_type                        national character varying(2) NOT NULL
                                            CHECK(transaction_type IN('Dr', 'Cr')),
    item_id                                 integer NOT NULL REFERENCES inventory.items,
    price                                   decimal(30, 6) NOT NULL,
    discount                                decimal(30, 6) NOT NULL DEFAULT(0),    
    cost_of_goods_sold                      decimal(30, 6) NOT NULL DEFAULT(0),
    tax                                        decimal(30, 6) NOT NULL DEFAULT(0),
    shipping_charge                         decimal(30, 6) NOT NULL DEFAULT(0),    
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    quantity                                decimal(30, 6) NOT NULL,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    base_quantity                           numeric(30, 6) NOT NULL,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE())
);

CREATE TABLE inventory.inventory_transfer_requests
(
    inventory_transfer_request_id           bigint IDENTITY PRIMARY KEY,
    office_id                               integer NOT NULL REFERENCES core.offices,
    user_id                                 integer NOT NULL REFERENCES account.users,
    store_id                                integer NOT NULL REFERENCES inventory.stores,
    request_date                            date NOT NULL,
    transaction_timestamp                   DATETIMEOFFSET NOT NULL DEFAULT(GETDATE()),
    reference_number                        national character varying(24),
    statement_reference                     national character varying(2000),
    authorized                              bit NOT NULL DEFAULT(0),
    authorized_by_user_id                   integer REFERENCES account.users,
    authorized_on                           DATETIMEOFFSET,
    authorization_reason                    national character varying(500),
    rejected                                bit NOT NULL DEFAULT(0),
    rejected_by_user_id                     integer REFERENCES account.users,
    rejected_on                             DATETIMEOFFSET,
    rejection_reason                        national character varying(500),
    received                                bit NOT NULL DEFAULT(0),
    received_by_user_id                     integer REFERENCES account.users,
    received_on                             DATETIMEOFFSET,
    receipt_memo                            national character varying(500),
    delivered                               bit NOT NULL DEFAULT(0),
    delivered_by_user_id                    integer REFERENCES account.users,
    delivered_on                            DATETIMEOFFSET,
    delivery_memo                           national character varying(500),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)    
);

CREATE TABLE inventory.inventory_transfer_request_details
(
    inventory_transfer_request_detail_id    bigint IDENTITY PRIMARY KEY,
    inventory_transfer_request_id           bigint NOT NULL REFERENCES inventory.inventory_transfer_requests,
    request_date                            date NOT NULL,
    item_id                                 integer NOT NULL REFERENCES inventory.items,
    quantity                                decimal(30, 6) NOT NULL,
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    base_quantity                           decimal(30, 6) NOT NULL
);

CREATE TABLE inventory.inventory_transfer_deliveries
(
    inventory_transfer_delivery_id          bigint IDENTITY PRIMARY KEY,
    inventory_transfer_request_id           bigint NOT NULL REFERENCES inventory.inventory_transfer_requests,
    office_id                               integer NOT NULL REFERENCES core.offices,
    user_id                                 integer NOT NULL REFERENCES account.users,
    destination_store_id                    integer NOT NULL REFERENCES inventory.stores,
    delivery_date                           date NOT NULL,
    transaction_timestamp                   DATETIMEOFFSET NOT NULL DEFAULT(GETDATE()),
    reference_number                        national character varying(24),
    statement_reference                     national character varying(2000),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)
);


CREATE TABLE inventory.inventory_transfer_delivery_details
(
    inventory_transfer_delivery_detail_id   bigint IDENTITY PRIMARY KEY,
    inventory_transfer_delivery_id          bigint NOT NULL REFERENCES inventory.inventory_transfer_deliveries,
    request_date                            date NOT NULL,
    item_id                                 integer NOT NULL REFERENCES inventory.items,
    quantity                                decimal(30, 6) NOT NULL,
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    base_quantity                           decimal(30, 6) NOT NULL
);


CREATE TABLE inventory.attributes
(
    attribute_id                            integer IDENTITY NOT NULL PRIMARY KEY,
    attribute_code                          national character varying(12) NOT NULL UNIQUE,
    attribute_name                          national character varying(100) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE TABLE inventory.variants
(
    variant_id                              integer IDENTITY NOT NULL PRIMARY KEY,
    variant_code                            national character varying(12) NOT NULL UNIQUE,
    variant_name                            national character varying(100) NOT NULL,
    attribute_id                            integer NOT NULL REFERENCES inventory.attributes,
    attribute_value                         national character varying(200) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE TABLE inventory.item_variants
(
    item_variant_id                         integer IDENTITY NOT NULL PRIMARY KEY,
    item_id                                 integer NOT NULL REFERENCES inventory.items,
    variant_id                              integer NOT NULL REFERENCES inventory.variants,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                DATETIMEOFFSET DEFAULT(GETDATE()),
    deleted                                    bit DEFAULT(0)
);

CREATE TABLE inventory.inventory_setup
(
    office_id                                integer NOT NULL PRIMARY KEY REFERENCES core.offices,
    inventory_system                        national character varying(50) NOT NULL
                                            CHECK(inventory_system IN('Periodic', 'Perpetual')),
    cogs_calculation_method                    national character varying(50) NOT NULL
                                            CHECK(cogs_calculation_method IN('FIFO', 'LIFO', 'MAVCO')),
    allow_multiple_opening_inventory        bit NOT NULL DEFAULT(0),
    default_discount_account_id                integer NOT NULL REFERENCES finance.accounts
);

CREATE TYPE inventory.transfer_type
AS TABLE
(
    tran_type       national character varying(2),
    store_name      national character varying(50),
    item_code       national character varying(12),
    unit_name       national character varying(50),
    quantity        decimal(30, 6),
    rate            decimal(30, 6)
);

CREATE TYPE inventory.adjustment_type 
AS TABLE
(
    tran_type       national character varying(2),
    item_code       national character varying(12),
    unit_name       national character varying(50),
    quantity        decimal(30, 6)
);


CREATE TYPE inventory.checkout_detail_type
AS TABLE
(
    store_id            integer,
    item_id               integer,
    quantity            decimal(30, 6),
    unit_id               national character varying(50),
    price               decimal(30, 6),
    discount            decimal(30, 6),
    tax                 decimal(30, 6),
    shipping_charge     decimal(30, 6)
);


CREATE TYPE inventory.opening_stock_type
AS TABLE
(
    store_id            integer,
    item_id               integer,
    quantity            decimal(30, 6),
    unit_id               integer,
    price                  decimal(30, 6)
);



GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.convert_unit.sql --<--<--
IF OBJECT_ID('inventory.convert_unit') IS NOT NULL
DROP FUNCTION inventory.convert_unit;

GO

CREATE FUNCTION inventory.convert_unit(@from_unit integer, @to_unit integer)
RETURNS decimal(30, 6)
AS
BEGIN
    DECLARE @factor decimal(30, 6);

    IF(inventory.get_root_unit_id(@from_unit) != inventory.get_root_unit_id(@to_unit))
    BEGIN
        RETURN 0;
    END;

    IF(@from_unit = @to_unit)
    BEGIN
        RETURN 1.00;
    END;
    
    IF(inventory.is_parent_unit(@from_unit, @to_unit) = 1)
    BEGIN
            WITH unit_cte(unit_id, value) AS 
            (
                SELECT tn.compare_unit_id, tn.value
                FROM inventory.compound_units AS tn 
                WHERE tn.base_unit_id = @from_unit
                AND tn.deleted = 0

                UNION ALL

                SELECT 
                c.compare_unit_id, c.value * p.value
                FROM unit_cte AS p, 
                inventory.compound_units AS c 
                WHERE base_unit_id = p.unit_id
            )
        SELECT @factor = 1.00/value
        FROM unit_cte
        WHERE unit_id=@to_unit;
    END
    ELSE
    BEGIN
            WITH unit_cte(unit_id, value) AS 
            (
             SELECT tn.compare_unit_id, tn.value
                FROM inventory.compound_units AS tn 
                WHERE tn.base_unit_id = @to_unit
                AND tn.deleted = 0
            UNION ALL
             SELECT 
                c.compare_unit_id, c.value * p.value
                FROM unit_cte AS p, 
              inventory.compound_units AS c 
                WHERE base_unit_id = p.unit_id
            )

        SELECT @factor = value
        FROM unit_cte
        WHERE unit_id=@from_unit;
    END;

    RETURN @factor;
END;






GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.count_item_in_stock.sql --<--<--
IF OBJECT_ID('inventory.count_item_in_stock') IS NOT NULL
DROP FUNCTION inventory.count_item_in_stock;

GO

CREATE FUNCTION inventory.count_item_in_stock(@item_id integer, @unit_id integer, @store_id integer)
RETURNS decimal(30, 6)
AS
BEGIN
    DECLARE @debit decimal(30, 6);
    DECLARE @credit decimal(30, 6);
    DECLARE @balance decimal(30, 6);

    SET @debit = inventory.count_purchases(@item_id, @unit_id, @store_id);
    SET @credit = inventory.count_sales(@item_id, @unit_id, @store_id);

    SET  @balance= @debit - @credit;    
    return @balance;  
END;




--SELECT * FROM inventory.count_item_in_stock(1, 1, 1);

GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.count_purchases.sql --<--<--
IF OBJECT_ID('inventory.count_purchases') IS NOT NULL
DROP FUNCTION inventory.count_purchases;

GO

CREATE FUNCTION inventory.count_purchases(@item_id integer, @unit_id integer, @store_id integer)
RETURNS decimal(30, 6)
AS
BEGIN
    DECLARE @base_unit_id integer;
    DECLARE @debit decimal(30, 6);
    DECLARE @factor decimal(30, 6);

    --Get the base item unit
    SELECT @base_unit_id= inventory.get_root_unit_id(inventory.items.unit_id) 
    FROM inventory.items
    WHERE inventory.items.item_id=@item_id
    AND inventory.items.deleted = 0;

    SELECT @debit =  COALESCE(SUM(base_quantity), 0)
    FROM inventory.checkout_details
    INNER JOIN inventory.checkouts
    ON inventory.checkouts.checkout_id = inventory.checkout_details.checkout_id
    INNER JOIN finance.transaction_master
    ON inventory.checkouts.transaction_master_id = finance.transaction_master.transaction_master_id
    WHERE finance.transaction_master.verification_status_id > 0
    AND inventory.checkout_details.item_id=@item_id
    AND inventory.checkout_details.store_id=@store_id
    AND inventory.checkout_details.transaction_type='Dr';

    SET @factor = inventory.convert_unit(@base_unit_id, @unit_id);    
    RETURN @debit * @factor;
END;


GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.count_sales.sql --<--<--
-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.count_sales.sql --<--<--
IF OBJECT_ID('inventory.count_sales') IS NOT NULL
DROP FUNCTION inventory.count_sales;

GO

CREATE FUNCTION inventory.count_sales(@item_id integer, @unit_id integer, @store_id integer)
RETURNS decimal(30, 6)
AS
BEGIN
    DECLARE @base_unit_id integer;
    DECLARE @credit decimal(30, 6);
    DECLARE @factor decimal(30, 6);

    --Get the base item unit
    SELECT @base_unit_id =  inventory.get_root_unit_id(inventory.items.unit_id) 
    FROM inventory.items
    WHERE inventory.items.item_id=@item_id
    AND inventory.items.deleted = 0;

    SELECT @credit =  COALESCE(SUM(base_quantity), 0)
    FROM inventory.checkout_details
    INNER JOIN inventory.checkouts
    ON inventory.checkouts.checkout_id = inventory.checkout_details.checkout_id
    INNER JOIN finance.transaction_master
    ON inventory.checkouts.transaction_master_id = finance.transaction_master.transaction_master_id
    WHERE finance.transaction_master.verification_status_id > 0
    AND inventory.checkout_details.item_id=@item_id
    AND inventory.checkout_details.store_id=@store_id
    AND inventory.checkout_details.transaction_type='Cr';

    SET @factor = inventory.convert_unit(@base_unit_id, @unit_id);
    RETURN @credit * @factor;
END;

GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_account_id_by_customer_id.sql --<--<--
IF OBJECT_ID('inventory.get_account_id_by_customer_id') IS NOT NULL
DROP FUNCTION inventory.get_account_id_by_customer_id;

GO

CREATE FUNCTION inventory.get_account_id_by_customer_id(@customer_id bigint)
RETURNS integer
AS
BEGIN
    RETURN
    (
	    SELECT inventory.customers.account_id
	    FROM inventory.customers
	    WHERE inventory.customers.customer_id=@customer_id
	    AND inventory.customers.deleted = 0
    );
END;


GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_account_id_by_shipper_id.sql --<--<--
IF OBJECT_ID('inventory.get_account_id_by_shipper_id') IS NOT NULL
DROP FUNCTION inventory.get_account_id_by_shipper_id;

GO

CREATE FUNCTION inventory.get_account_id_by_shipper_id(@shipper_id integer)
RETURNS integer
AS
BEGIN
    RETURN
    (
	    SELECT inventory.shippers.account_id
	    FROM inventory.shippers
	    WHERE inventory.shippers.shipper_id=@shipper_id
	    AND inventory.shippers.deleted = 0
    );
END;

GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_account_id_by_supplier_id.sql --<--<--
IF OBJECT_ID('inventory.get_account_id_by_supplier_id') IS NOT NULL
DROP FUNCTION inventory.get_account_id_by_supplier_id;

GO

CREATE FUNCTION inventory.get_account_id_by_supplier_id(@supplier_id integer)
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT
	        inventory.suppliers.account_id
	    FROM inventory.suppliers
	    WHERE inventory.suppliers.supplier_id = @supplier_id
	    AND inventory.suppliers.deleted = 0
	);
END;





GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_account_statement.sql --<--<--
IF OBJECT_ID('inventory.get_account_statement') IS NOT NULL
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


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_associated_unit_list.sql --<--<--
IF OBJECT_ID('inventory.get_associated_unit_list') IS NOT NULL
DROP FUNCTION inventory.get_associated_unit_list;

GO

CREATE FUNCTION inventory.get_associated_unit_list(@any_unit_id integer)
RETURNS @result TABLE
(
    unit_id             integer
)
AS
BEGIN
    DECLARE @root_unit_id integer = inventory.get_root_unit_id(@any_unit_id);
        
    INSERT INTO @result(unit_id) 
    SELECT @root_unit_id
    WHERE NOT EXISTS
    (
        SELECT * FROM @result
        WHERE unit_id=@root_unit_id
    );
    
    WITH cte(unit_id)
    AS
    (
         SELECT 
            compare_unit_id
         FROM 
            inventory.compound_units
         WHERE 
            base_unit_id = @root_unit_id

        UNION ALL

         SELECT
            units.compare_unit_id
         FROM 
            inventory.compound_units units
         INNER JOIN cte 
         ON cte.unit_id = units.base_unit_id
    )
    
    INSERT INTO @result(unit_id)
    SELECT cte.unit_id FROM cte;
    
    DELETE FROM @result
    WHERE unit_id IS NULL;
    
    RETURN;
END;



--SELECT * FROM inventory.get_associated_unit_list(1);

GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_associated_units.sql --<--<--
IF OBJECT_ID('inventory.get_associated_unit_csv_list') IS NOT NULL
DROP FUNCTION inventory.get_associated_unit_csv_list;

GO

CREATE FUNCTION inventory.get_associated_unit_csv_list(@any_unit_id integer)
RETURNS @result TABLE
(
    unit_id             integer
)
AS
BEGIN
    DECLARE @root_unit_id integer = inventory.get_root_unit_id(@any_unit_id);
        
    INSERT INTO @result(unit_id) 
    SELECT @root_unit_id
    WHERE NOT EXISTS
    (
        SELECT * FROM @result
        WHERE unit_id=@root_unit_id
    );
    
    WITH cte(unit_id)
    AS
    (
         SELECT 
            compare_unit_id
         FROM 
            inventory.compound_units
         WHERE 
            base_unit_id = @root_unit_id

        UNION ALL

         SELECT
            units.compare_unit_id
         FROM 
            inventory.compound_units units
         INNER JOIN cte 
         ON cte.unit_id = units.base_unit_id
    )
    
    INSERT INTO @result(unit_id)
    SELECT cte.unit_id FROM cte;
    
    DELETE FROM @result
    WHERE unit_id IS NULL;
    
    RETURN;
END;



GO


--SELECT * FROM inventory.get_associated_unit_list(24);


IF OBJECT_ID('inventory.get_associated_unit_list_csv') IS NOT NULL
DROP FUNCTION inventory.get_associated_unit_list_csv;

GO

CREATE FUNCTION inventory.get_associated_unit_list_csv(@any_unit_id integer)
RETURNS varchar(MAX)
AS
BEGIN
    DECLARE @result TABLE
    (
        unit_id integer, 
        unit_code national character varying(24), 
        unit_name national character varying(500)
    );

    DECLARE @csv varchar(MAX);
    INSERT INTO @result(unit_id)
    SELECT * FROM inventory.get_associated_unit_list(@any_unit_id);

    SELECT @csv = COALESCE(@csv + ',', '') +  CONVERT(varchar, unit_id)
    FROM @result
    ORDER BY unit_id;
        
    RETURN @csv;
END;



GO


--SELECT inventory.get_associated_unit_list_csv(24);




-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_associated_units_by_item_id.sql --<--<--
IF OBJECT_ID('inventory.get_associated_units_by_item_id') IS NOT NULL
DROP FUNCTION inventory.get_associated_units_by_item_id;

GO

CREATE FUNCTION inventory.get_associated_units_by_item_id(@item_id integer)
RETURNS @result TABLE
(
    unit_id integer, 
    unit_code national character varying(24), 
    unit_name national character varying(500)
)
AS
BEGIN
    DECLARE @unit_id integer;

    SELECT @unit_id = inventory.items.unit_id
    FROM inventory.items
    WHERE inventory.items.item_id = @item_id
    AND inventory.items.deleted = 0;

    INSERT INTO @result
    SELECT * FROM inventory.get_associated_units(@unit_id);

    RETURN;
END;

GO


IF OBJECT_ID('inventory.get_associated_units_by_item_code') IS NOT NULL
DROP FUNCTION inventory.get_associated_units_by_item_code;

GO

CREATE FUNCTION inventory.get_associated_units_by_item_code(@item_code national character varying(24))
RETURNS @result TABLE
(
    unit_id integer, 
    unit_code national character varying(24), 
    unit_name national character varying(500)
)
AS
BEGIN
    DECLARE @unit_id integer;

    SELECT @unit_id = inventory.items.unit_id
    FROM inventory.items
    WHERE LOWER(item_code) = LOWER(@item_code)
    AND inventory.items.deleted = 0;

    INSERT INTO @result
    SELECT * FROM inventory.get_associated_units(@unit_id);

    RETURN;
END;


GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_base_quantity_by_unit_name.sql --<--<--


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_base_quantity_by_unit_name.sql --<--<--
IF OBJECT_ID('inventory.get_base_quantity_by_unit_name') IS NOT NULL
DROP FUNCTION inventory.get_base_quantity_by_unit_name;

GO

CREATE FUNCTION inventory.get_base_quantity_by_unit_name(@unit_name national character varying(500), @multiplier numeric(30, 6))
RETURNS decimal(30, 6)
AS
BEGIN
    DECLARE @unit_id integer;
    DECLARE @root_unit_id integer;
    DECLARE @factor decimal(30, 6);

    SET @unit_id = inventory.get_unit_id_by_unit_name(@unit_name);
    SET @root_unit_id = inventory.get_root_unit_id(@unit_id);
    SET @factor = inventory.convert_unit(@unit_id, @root_unit_id);

    RETURN @factor * @multiplier;
END;

GO

IF OBJECT_ID('inventory.get_base_quantity_by_unit_id') IS NOT NULL
DROP FUNCTION inventory.get_base_quantity_by_unit_id;

GO

CREATE FUNCTION inventory.get_base_quantity_by_unit_id(@unit_id integer, @multiplier numeric(30, 6))
RETURNS decimal(30, 6)
AS
BEGIN
    DECLARE @root_unit_id integer;
    DECLARE @factor decimal(30, 6);

    SET @root_unit_id = inventory.get_root_unit_id(@unit_id);
    SET @factor = inventory.convert_unit(@root_unit_id, @root_unit_id);

    RETURN @factor * @multiplier;
END;

GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_base_unit_id_by_unit_name.sql --<--<--
IF OBJECT_ID('inventory.get_base_unit_id_by_unit_name') IS NOT NULL
DROP FUNCTION inventory.get_base_unit_id_by_unit_name;

GO

CREATE FUNCTION inventory.get_base_unit_id_by_unit_name(@unit_name national character varying(500))
RETURNS integer
AS
BEGIN
    DECLARE @unit_id integer;

    SET @unit_id = inventory.get_unit_id_by_unit_name(@unit_name);

    RETURN inventory.get_root_unit_id(@unit_id);
END;


GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_brand_id_by_brand_code.sql --<--<--
IF OBJECT_ID('inventory.get_brand_id_by_brand_code') IS NOT NULL
DROP FUNCTION inventory.get_brand_id_by_brand_code;

GO

CREATE FUNCTION inventory.get_brand_id_by_brand_code(@brand_code national character varying(24))
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT brand_id
	    FROM inventory.brands
	    WHERE inventory.brands.brand_code=@brand_code
	    AND inventory.brands.deleted = 0
    );
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_cash_account_id_by_store_id.sql --<--<--
IF OBJECT_ID('inventory.get_cash_account_id_by_store_id') IS NOT NULL
DROP FUNCTION inventory.get_cash_account_id_by_store_id;

GO

CREATE FUNCTION inventory.get_cash_account_id_by_store_id(@store_id integer)
RETURNS bigint
AS
BEGIN
    RETURN
    (
	    SELECT inventory.stores.default_cash_account_id
	    FROM inventory.stores
	    WHERE inventory.stores.store_id=@store_id
	    AND inventory.stores.deleted = 0
    );
END;






GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_cash_repository_id_by_store_id.sql --<--<--
IF OBJECT_ID('inventory.get_cash_repository_id_by_store_id') IS NOT NULL
DROP FUNCTION inventory.get_cash_repository_id_by_store_id;

GO

CREATE FUNCTION inventory.get_cash_repository_id_by_store_id(@store_id integer)
RETURNS bigint
AS
BEGIN
    RETURN
    (
	    SELECT inventory.stores.default_cash_repository_id
	    FROM inventory.stores
	    WHERE inventory.stores.store_id=@store_id
	    AND inventory.stores.deleted = 0
    );
END;





GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_checkout_id_by_transaction_master_id.sql --<--<--
IF OBJECT_ID('inventory.get_checkout_id_by_transaction_master_id') IS NOT NULL
DROP FUNCTION inventory.get_checkout_id_by_transaction_master_id;

GO

CREATE FUNCTION inventory.get_checkout_id_by_transaction_master_id(@transaction_master_id bigint)
RETURNS bigint
AS

BEGIN
    RETURN
    (
        SELECT inventory.checkouts.checkout_id
        FROM inventory.checkouts
        WHERE inventory.checkouts.transaction_master_id=@transaction_master_id
    );
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_cost_of_good_method.sql --<--<--
IF OBJECT_ID('inventory.get_cost_of_good_method') IS NOT NULL
DROP FUNCTION inventory.get_cost_of_good_method;

GO

CREATE FUNCTION inventory.get_cost_of_good_method(@office_id integer)
RETURNS national character varying(500)
AS

BEGIN
    RETURN
    (
	    SELECT inventory.inventory_setup.cogs_calculation_method
	    FROM inventory.inventory_setup
	    WHERE inventory.inventory_setup.office_id=@office_id
    );
END;



--SELECT * FROM inventory.get_cost_of_good_method(1);

GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_cost_of_goods_sold.sql --<--<--
-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_cost_of_goods_sold.sql --<--<--
IF OBJECT_ID('inventory.get_cost_of_goods_sold') IS NOT NULL
DROP FUNCTION inventory.get_cost_of_goods_sold;

GO

CREATE FUNCTION inventory.get_cost_of_goods_sold(@item_id integer, @unit_id integer, @store_id integer, @quantity decimal(30, 6))
RETURNS decimal(30, 6)
AS
BEGIN
    DECLARE @backup_quantity            decimal(30, 6);
    DECLARE @base_quantity              decimal(30, 6);
    DECLARE @base_unit_id               integer;
    DECLARE @base_unit_cost             decimal(30, 6);
    DECLARE @total_sold                 integer;
    DECLARE @office_id                  integer = inventory.get_office_id_by_store_id(@store_id);
    DECLARE @method                     national character varying(1000) = inventory.get_cost_of_good_method(@office_id);

    --backup base quantity in decimal(30, 6)
    SET @backup_quantity                = inventory.get_base_quantity_by_unit_id(@unit_id, @quantity);
    --convert base quantity to whole number
    SET @base_quantity                  = CEILING(@backup_quantity);
    SET @base_unit_id                   = inventory.get_root_unit_id(@unit_id);
        
    IF(@method = 'MAVCO')
    BEGIN
        RETURN transactions.get_mavcogs(@item_id, @store_id, @base_quantity, 1.00);
    END; 


    SELECT @total_sold = COALESCE(SUM(base_quantity), 0)
    FROM inventory.verified_checkout_details_view
    WHERE transaction_type='Cr';

    DECLARE @temp_cost_of_goods_sold TABLE
    (
        id                     bigint IDENTITY,
        checkout_detail_id     bigint,
        audit_ts               DATETIMEOFFSET,
        value_date             date,
        price                  decimal(30, 6),
        transaction_type       national character varying(1000)
                    
    ) ;


    /*TODO:
    ALTERNATIVE AND MUCH EFFICIENT APPROACH
        SELECT
            *,
            (
                SELECT SUM(base_quantity)
                FROM inventory.verified_checkout_details_view AS i
                WHERE i.checkout_detail_id <= v.checkout_detail_id
                AND item_id = 1
            ) AS total
        FROM inventory.verified_checkout_details_view AS v
        WHERE item_id = 1
        ORDER BY value_date, checkout_id;
    */

    WITH stock_cte AS
    (
        SELECT
            checkout_detail_id, 
            audit_ts,
            value_date,
            series.generate_series AS series,
            (price * quantity) / base_quantity AS price,
            transaction_type
        FROM inventory.verified_checkout_details_view
        CROSS APPLY core.generate_series(1, CAST(inventory.verified_checkout_details_view.base_quantity AS integer)) AS series
        WHERE item_id = @item_id
        AND store_id = @store_id
    )
        
    INSERT INTO @temp_cost_of_goods_sold(checkout_detail_id, audit_ts, value_date, price, transaction_type)
    SELECT checkout_detail_id, audit_ts, value_date, price, transaction_type FROM stock_cte
    ORDER BY value_date, audit_ts, checkout_detail_id;


    IF(@method = 'LIFO')
    BEGIN
        SELECT @base_unit_cost = SUM(price)
        FROM 
        (
            SELECT price
            FROM @temp_cost_of_goods_sold
            WHERE transaction_type ='Dr'
            ORDER BY id DESC
            OFFSET @total_sold ROWS
            FETCH NEXT CAST(@base_quantity AS integer) ROWS ONLY
        ) S;
    END
    ELSE IF (@method = 'FIFO')
    BEGIN
        SELECT @base_unit_cost = SUM(price)
        FROM 
        (
            SELECT price
            FROM @temp_cost_of_goods_sold
            WHERE transaction_type ='Dr'
            ORDER BY id
            OFFSET @total_sold ROWS
            FETCH NEXT CAST(@base_quantity AS integer) ROWS ONLY
        ) S;
    END
    ELSE IF (@method != 'MAVCO')
    BEGIN
        RETURN 0;
        --RAISERROR('Invalid configuration: COGS method.', 10, 1);
    END;

    --APPLY decimal(30, 6) QUANTITY PROVISON
    SET @base_unit_cost = @base_unit_cost * (@backup_quantity / @base_quantity);

    RETURN @base_unit_cost;
END;



--SELECT * FROM inventory.get_cost_of_goods_sold(1,1, 1, 3.5);

GO

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_cost_of_goods_sold_account_id.sql --<--<--
IF OBJECT_ID('inventory.get_cost_of_goods_sold_account_id') IS NOT NULL
DROP FUNCTION inventory.get_cost_of_goods_sold_account_id;

GO

CREATE FUNCTION inventory.get_cost_of_goods_sold_account_id(@item_id integer)
RETURNS integer
AS
BEGIN
    RETURN
    (
	    SELECT
	        cost_of_goods_sold_account_id
	    FROM inventory.item_groups
	    INNER JOIN inventory.items
	    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
	    WHERE inventory.items.item_id = @item_id
	    AND inventory.item_groups.deleted = 0
	);
END;



--SELECT inventory.get_cost_of_goods_sold_account_id(1);

GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_currency_code_by_customer_id.sql --<--<--
IF OBJECT_ID('inventory.get_currency_code_by_customer_id') IS NOT NULL
DROP FUNCTION inventory.get_currency_code_by_customer_id;

GO

CREATE FUNCTION inventory.get_currency_code_by_customer_id(@customer_id integer)
RETURNS national character varying(12)
AS

BEGIN
    RETURN
    (
	    SELECT inventory.customers.currency_code
	    FROM inventory.customers
	    WHERE inventory.customers.customer_id = @customer_id
	    AND inventory.customers.deleted = 0
    );
END



GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_currency_code_by_supplier_id.sql --<--<--
IF OBJECT_ID('inventory.get_currency_code_by_supplier_id') IS NOT NULL
DROP FUNCTION inventory.get_currency_code_by_supplier_id;

GO

CREATE FUNCTION inventory.get_currency_code_by_supplier_id(@supplier_id integer)
RETURNS national character varying(12)
AS

BEGIN
    RETURN
    (
	    SELECT inventory.suppliers.currency_code
	    FROM inventory.suppliers
	    WHERE inventory.suppliers.supplier_id = @supplier_id
	    AND inventory.suppliers.deleted = 0
    );
END



GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_customer_id_by_customer_code.sql --<--<--
IF OBJECT_ID('inventory.get_customer_id_by_customer_code') IS NOT NULL
DROP FUNCTION inventory.get_customer_id_by_customer_code;

GO

CREATE FUNCTION inventory.get_customer_id_by_customer_code(@customer_code national character varying(24))
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT customer_id
	    FROM inventory.customers
	    WHERE inventory.customers.customer_code=@customer_code
	    AND inventory.customers.deleted = 0
    );
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_customer_name_by_customer_id.sql --<--<--
IF OBJECT_ID('inventory.get_customer_name_by_customer_id') IS NOT NULL
DROP FUNCTION inventory.get_customer_name_by_customer_id;

GO

CREATE FUNCTION inventory.get_customer_name_by_customer_id(@customer_id integer)
RETURNS national character varying(500)
AS

BEGIN
    RETURN
    (
	    SELECT inventory.customers.customer_name
	    FROM inventory.customers
	    WHERE inventory.customers.customer_id = @customer_id
    );
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_customer_type_id_by_customer_id.sql --<--<--
IF OBJECT_ID('inventory.get_customer_type_id_by_customer_id') IS NOT NULL
DROP FUNCTION inventory.get_customer_type_id_by_customer_id;

GO

CREATE FUNCTION inventory.get_customer_type_id_by_customer_id(@customer_id integer)
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT inventory.customers.customer_type_id
	    FROM inventory.customers
	    WHERE inventory.customers.customer_id = @customer_id
	    AND inventory.customers.deleted = 0
    );
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_customer_type_id_by_customer_type_code.sql --<--<--
IF OBJECT_ID('inventory.get_customer_type_id_by_customer_type_code') IS NOT NULL
DROP FUNCTION inventory.get_customer_type_id_by_customer_type_code;

GO

CREATE FUNCTION inventory.get_customer_type_id_by_customer_type_code(@customer_type_code national character varying(24))
RETURNS integer
AS
BEGIN
    RETURN
    (
	    SELECT customer_type_id
	    FROM inventory.customer_types
	    WHERE inventory.customer_types.customer_type_code=@customer_type_code
	    AND inventory.customer_types.deleted = 0
    );
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_inventory_account_id.sql --<--<--
IF OBJECT_ID('inventory.get_inventory_account_id') IS NOT NULL
DROP FUNCTION inventory.get_inventory_account_id;

GO

CREATE FUNCTION inventory.get_inventory_account_id(@item_id integer)
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT
	        inventory_account_id
	    FROM inventory.item_groups
	    INNER JOIN inventory.items
	    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
	    WHERE inventory.items.item_id = @item_id
	    AND inventory.item_groups.deleted = 0
	);
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_item_code_by_item_id.sql --<--<--
IF OBJECT_ID('inventory.get_item_code_by_item_id') IS NOT NULL
DROP FUNCTION inventory.get_item_code_by_item_id;

GO

CREATE FUNCTION inventory.get_item_code_by_item_id(@item_id integer)
RETURNS character varying AS

BEGIN
    RETURN
    (
	    SELECT item_code
	    FROM inventory.items
	    WHERE inventory.items.item_id = @item_id
	    AND inventory.items.deleted = 0
    );
END

GO



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_item_cost_price.sql --<--<--
-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_item_cost_price.sql --<--<--
IF OBJECT_ID('inventory.get_item_cost_price') IS NOT NULL
DROP FUNCTION inventory.get_item_cost_price;

GO

CREATE FUNCTION inventory.get_item_cost_price(@item_id integer, @unit_id integer)
RETURNS decimal(30, 6)
AS  
BEGIN    
    DECLARE @price              decimal(30, 6);
    DECLARE @costing_unit_id    integer;
    DECLARE @factor             decimal(30, 6);

    SELECT 
        @price = cost_price, 
        @costing_unit_id = unit_id
    FROM inventory.items
    WHERE inventory.items.item_id = @item_id
    AND inventory.items.deleted = 0;

    --Get the unitary conversion factor if the requested unit does not match with the price defition.
    SET @factor = inventory.convert_unit(@unit_id, @costing_unit_id);
    RETURN @price * @factor;
END;



--SELECT * FROM inventory.get_item_cost_price(6, 7);


GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_item_group_id_by_item_group_code.sql --<--<--
IF OBJECT_ID('inventory.get_item_group_id_by_item_group_code') IS NOT NULL
DROP FUNCTION inventory.get_item_group_id_by_item_group_code;

GO

CREATE FUNCTION inventory.get_item_group_id_by_item_group_code(@item_group_code national character varying(24))
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT item_group_id
	    FROM inventory.item_groups
	    WHERE inventory.item_groups.item_group_code=@item_group_code
	    AND inventory.item_groups.deleted = 0
    );
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_item_id_by_item_code.sql --<--<--
IF OBJECT_ID('inventory.get_item_id_by_item_code') IS NOT NULL
DROP FUNCTION inventory.get_item_id_by_item_code;

GO

CREATE FUNCTION inventory.get_item_id_by_item_code(@item_code national character varying(24))
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT item_id
	    FROM inventory.items
	    WHERE inventory.items.item_code = @item_code
	    AND inventory.items.deleted = 0
    );
END



GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_item_name_by_item_id.sql --<--<--
IF OBJECT_ID('inventory.get_item_name_by_item_id') IS NOT NULL
DROP FUNCTION inventory.get_item_name_by_item_id;

GO

CREATE FUNCTION inventory.get_item_name_by_item_id(@item_id int)
RETURNS character varying(50) AS
BEGIN
    RETURN
    (
	    SELECT item_name
	    FROM inventory.items
	    WHERE inventory.items.item_id = @item_id
	    AND inventory.items.deleted = 0
    );
END

GO



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_item_type_id_by_item_type_code.sql --<--<--
IF OBJECT_ID('inventory.get_item_type_id_by_item_type_code') IS NOT NULL
DROP FUNCTION inventory.get_item_type_id_by_item_type_code;

GO

CREATE FUNCTION inventory.get_item_type_id_by_item_type_code(@item_type_code national character varying(24))
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT item_type_id
	    FROM inventory.item_types
	    WHERE inventory.item_types.item_type_code=@item_type_code 
	    AND inventory.item_types.deleted = 0
    );
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_mavcogs.sql --<--<--
IF OBJECT_ID('inventory.get_mavcogs') IS NOT NULL
DROP FUNCTION inventory.get_mavcogs;

GO

CREATE FUNCTION inventory.get_mavcogs(@item_id integer, @store_id integer, @base_quantity numeric(30, 6), @factor numeric(30, 6))
RETURNS numeric(30, 6)
AS
BEGIN
    DECLARE @base_unit_cost decimal(30, 6);

    DECLARE @temp_staging TABLE
    (
        id              integer IDENTITY NOT NULL,
        value_date      date,
        audit_ts        DATETIMEOFFSET,
        base_quantity   numeric(30, 6),
        price           numeric(30, 6)
    ) ;


    INSERT INTO @temp_staging(value_date, audit_ts, base_quantity, price)
    SELECT value_date, audit_ts, 
    CASE WHEN transaction_type = 'Dr' THEN
    base_quantity ELSE base_quantity  * -1 END, 
    CASE WHEN transaction_type = 'Dr' THEN
    (price * quantity/base_quantity)
    ELSE
    0
    END
    FROM inventory.verified_checkout_details_view
    WHERE item_id = @item_id
    AND store_id=@store_id
    order by value_date, audit_ts, checkout_detail_id;




    WITH stock_transaction(id, base_quantity, price, sum_m, sum_base_quantity, last_id) AS 
    (
      SELECT id, base_quantity, price, base_quantity * price, base_quantity, id
      FROM @temp_staging WHERE id = 1
      UNION ALL
      SELECT child.id, child.base_quantity, 
             CAST(CASE WHEN child.base_quantity < 0 then parent.sum_m / parent.sum_base_quantity ELSE child.price END AS numeric(30, 6)), 
             parent.sum_m + CASE WHEN child.base_quantity < 0 then parent.sum_m / parent.sum_base_quantity ELSE child.price END * child.base_quantity,
             CAST(parent.sum_base_quantity + child.base_quantity AS numeric(30, 6)),
             child.id 
      FROM @temp_staging child JOIN stock_transaction parent on child.id = parent.last_id + 1
    )

    SELECT
    TOP 1
            --base_quantity,                                                        --left for debuging purpose
            --price,                                                                --left for debuging purpose
            --base_quantity * price AS amount,                                      --left for debuging purpose
            --SUM(base_quantity * price) OVER(ORDER BY id) AS cv_amount,            --left for debuging purpose
            --SUM(base_quantity) OVER(ORDER BY id) AS cv_quantity,                  --left for debuging purpose
            @base_unit_cost = SUM(base_quantity * price) OVER(ORDER BY id)  / SUM(base_quantity) OVER(ORDER BY id)
    FROM stock_transaction
    ORDER BY id DESC;

    RETURN @base_unit_cost * @factor * @base_quantity;
END;






GO




-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_office_id_by_store_id.sql --<--<--
IF OBJECT_ID('inventory.get_office_id_by_store_id') IS NOT NULL
DROP FUNCTION inventory.get_office_id_by_store_id;

GO

CREATE FUNCTION inventory.get_office_id_by_store_id(@store_id integer)
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT inventory.stores.office_id
	    FROM inventory.stores
	    WHERE inventory.stores.store_id=@store_id
	    AND inventory.stores.deleted = 0
    );
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_opening_inventory_status.sql --<--<--

-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_opening_inventory_status.sql --<--<--
IF OBJECT_ID('inventory.get_opening_inventory_status') IS NOT NULL
DROP FUNCTION inventory.get_opening_inventory_status;

GO

CREATE FUNCTION inventory.get_opening_inventory_status
(
    @office_id                                      integer
)
RETURNS @result TABLE
(
    office_id                                       integer,
    multiple_inventory_allowed                      bit,
    has_opening_inventory                           bit
)
AS
BEGIN
    DECLARE @multiple_inventory_allowed             bit;
    DECLARE @has_opening_inventory                  bit = 0;

    SELECT @multiple_inventory_allowed = inventory.inventory_setup.allow_multiple_opening_inventory 
    FROM inventory.inventory_setup
    WHERE inventory.inventory_setup.office_id = @office_id;

    IF EXISTS
    (
        SELECT 1
        FROM finance.transaction_master
        WHERE finance.transaction_master.book = 'Opening Inventory'
        AND finance.transaction_master.office_id = @office_id
    )
    BEGIN
        SET @has_opening_inventory                      = 1;
    END;
    
    INSERT INTO @result
    SELECT @office_id, @multiple_inventory_allowed, @has_opening_inventory;

    RETURN;
END;



--SELECT * FROM inventory.get_opening_inventory_status(1);

GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_purchase_account_id.sql --<--<--
IF OBJECT_ID('inventory.get_purchase_account_id') IS NOT NULL
DROP FUNCTION inventory.get_purchase_account_id;

GO

CREATE FUNCTION inventory.get_purchase_account_id(@item_id integer)
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT
	        purchase_account_id
	    FROM inventory.item_groups
	    INNER JOIN inventory.items
	    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
	    WHERE inventory.items.item_id = @item_id
	    AND inventory.item_groups.deleted = 0
	);
END;





GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_purchase_discount_account_id.sql --<--<--
IF OBJECT_ID('inventory.get_purchase_discount_account_id') IS NOT NULL
DROP FUNCTION inventory.get_purchase_discount_account_id;

GO

CREATE FUNCTION inventory.get_purchase_discount_account_id(@item_id integer)
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT
	        purchase_discount_account_id
	    FROM inventory.item_groups
	    INNER JOIN inventory.items
	    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
	    WHERE inventory.items.item_id = @item_id
	    AND inventory.item_groups.deleted = 0
	);
END;





GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_root_unit_id.sql --<--<--
IF OBJECT_ID('inventory.get_root_unit_id') IS NOT NULL
DROP FUNCTION inventory.get_root_unit_id;

GO

CREATE FUNCTION inventory.get_root_unit_id(@any_unit_id integer)
RETURNS integer
AS
BEGIN
    DECLARE @root_unit_id integer;

    SELECT @root_unit_id = base_unit_id
    FROM inventory.compound_units
    WHERE inventory.compound_units.compare_unit_id=@any_unit_id
    AND inventory.compound_units.deleted = 0;

    IF(@root_unit_id IS NULL)
    BEGIN
        RETURN @any_unit_id;
    END

    RETURN inventory.get_root_unit_id(@root_unit_id);
END;

GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_sales_account_id.sql --<--<--
IF OBJECT_ID('inventory.get_sales_account_id') IS NOT NULL
DROP FUNCTION inventory.get_sales_account_id;

GO

CREATE FUNCTION inventory.get_sales_account_id(@item_id integer)
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT inventory.item_groups.sales_account_id
	    FROM inventory.item_groups
	    INNER JOIN inventory.items
	    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
	    WHERE inventory.items.item_id = @item_id
	    AND inventory.item_groups.deleted = 0
    );
END;





GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_sales_discount_account_id.sql --<--<--
IF OBJECT_ID('inventory.get_sales_discount_account_id') IS NOT NULL
DROP FUNCTION inventory.get_sales_discount_account_id;

GO

CREATE FUNCTION inventory.get_sales_discount_account_id(@item_id integer)
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT inventory.item_groups.sales_discount_account_id
	    FROM inventory.item_groups
	    INNER JOIN inventory.items
	    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
	    WHERE inventory.items.item_id = @item_id
	    AND inventory.item_groups.deleted = 0
    );
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_sales_return_account_id.sql --<--<--
IF OBJECT_ID('inventory.get_sales_return_account_id') IS NOT NULL
DROP FUNCTION inventory.get_sales_return_account_id;

GO

CREATE FUNCTION inventory.get_sales_return_account_id(@item_id integer)
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT inventory.item_groups.sales_return_account_id
	    FROM inventory.item_groups
	    INNER JOIN inventory.items
	    ON inventory.item_groups.item_group_id = inventory.items.item_group_id
	    WHERE inventory.items.item_id = @item_id
	    AND inventory.item_groups.deleted = 0
    );
END;





GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_shipper_id_by_shipper_code.sql --<--<--
IF OBJECT_ID('inventory.get_shipper_id_by_shipper_code') IS NOT NULL
DROP FUNCTION inventory.get_shipper_id_by_shipper_code;

GO

CREATE FUNCTION inventory.get_shipper_id_by_shipper_code(@shipper_code national character varying(24))
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT inventory.shippers.shipper_id
	    FROM inventory.shippers
	    WHERE inventory.shippers.shipper_code = @shipper_code
    );
END



GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_shipper_id_by_shipper_name.sql --<--<--
IF OBJECT_ID('inventory.get_shipper_id_by_shipper_name') IS NOT NULL
DROP FUNCTION inventory.get_shipper_id_by_shipper_name;

GO

CREATE FUNCTION inventory.get_shipper_id_by_shipper_name(@shipper_name national character varying(24))
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT inventory.shippers.shipper_id
	    FROM inventory.shippers
	    WHERE inventory.shippers.shipper_name = @shipper_name
    );
END



GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_store_id_by_store_code.sql --<--<--
IF OBJECT_ID('inventory.get_store_id_by_store_code') IS NOT NULL
DROP FUNCTION inventory.get_store_id_by_store_code;

GO

CREATE FUNCTION inventory.get_store_id_by_store_code(@store_code national character varying(24))
RETURNS integer
AS
BEGIN
    RETURN
    (
        SELECT inventory.stores.store_id
        FROM inventory.stores
        WHERE inventory.stores.store_code=@store_code 
        AND inventory.stores.deleted = 0
    );
END;





GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_store_id_by_store_name.sql --<--<--
IF OBJECT_ID('inventory.get_store_id_by_store_name') IS NOT NULL
DROP FUNCTION inventory.get_store_id_by_store_name;

GO

CREATE FUNCTION inventory.get_store_id_by_store_name(@store_name national character varying(500))
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT store_id
	    FROM inventory.stores
	    WHERE inventory.stores.store_name = @store_name
	    AND inventory.stores.deleted = 0
    );
END



GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_store_name_by_store_id.sql --<--<--
IF OBJECT_ID('inventory.get_store_name_by_store_id') IS NOT NULL
DROP FUNCTION inventory.get_store_name_by_store_id;

GO

CREATE FUNCTION inventory.get_store_name_by_store_id(@store_id integer)
RETURNS national character varying(500)
AS

BEGIN
    RETURN
    (
	    SELECT store_name
	    FROM inventory.stores
	    WHERE inventory.stores.store_id = @store_id
	    AND inventory.stores.deleted = 0
    );
END



GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_store_type_id_by_store_type_code.sql --<--<--
IF OBJECT_ID('inventory.get_store_type_id_by_store_type_code') IS NOT NULL
DROP FUNCTION inventory.get_store_type_id_by_store_type_code;

GO

CREATE FUNCTION inventory.get_store_type_id_by_store_type_code(@store_type_code national character varying(24))
RETURNS integer
AS
BEGIN
    RETURN
    (
	    SELECT store_type_id
	    FROM inventory.store_types
	    WHERE inventory.store_types.store_type_code=@store_type_code
	    AND inventory.store_types.deleted = 0
    );
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_supplier_id_by_supplier_code.sql --<--<--
IF OBJECT_ID('inventory.get_supplier_id_by_supplier_code') IS NOT NULL
DROP FUNCTION inventory.get_supplier_id_by_supplier_code;

GO

CREATE FUNCTION inventory.get_supplier_id_by_supplier_code(@supplier_code national character varying(24))
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT supplier_id
	    FROM inventory.suppliers
	    WHERE inventory.suppliers.supplier_code=@supplier_code
	    AND inventory.suppliers.deleted = 0
    );
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_supplier_name_by_supplier_id.sql --<--<--
IF OBJECT_ID('inventory.get_supplier_name_by_supplier_id') IS NOT NULL
DROP FUNCTION inventory.get_supplier_name_by_supplier_id;

GO

CREATE FUNCTION inventory.get_supplier_name_by_supplier_id(@supplier_id integer)
RETURNS national character varying(500)
AS

BEGIN
    RETURN
    (
	    SELECT inventory.suppliers.supplier_name
	    FROM inventory.suppliers
	    WHERE inventory.suppliers.supplier_id = @supplier_id
    );
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_supplier_type_id_by_supplier_type_code.sql --<--<--
IF OBJECT_ID('inventory.get_supplier_type_id_by_supplier_type_code') IS NOT NULL
DROP FUNCTION inventory.get_supplier_type_id_by_supplier_type_code;

GO

CREATE FUNCTION inventory.get_supplier_type_id_by_supplier_type_code(@supplier_type_code national character varying(24))
RETURNS integer
AS
BEGIN
    RETURN
    (
	    SELECT supplier_type_id
	    FROM inventory.supplier_types
	    WHERE inventory.supplier_types.supplier_type_code=@supplier_type_code
	    AND inventory.supplier_types.deleted = 0
    );
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_unit_id_by_unit_code.sql --<--<--
IF OBJECT_ID('inventory.get_unit_id_by_unit_code') IS NOT NULL
DROP FUNCTION inventory.get_unit_id_by_unit_code;

GO

CREATE FUNCTION inventory.get_unit_id_by_unit_code(@unit_code national character varying(24))
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT inventory.units.unit_id
	    FROM inventory.units
	    WHERE inventory.units.unit_code=@unit_code
	    AND inventory.units.deleted = 0
    );
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_unit_id_by_unit_name.sql --<--<--
IF OBJECT_ID('inventory.get_unit_id_by_unit_name') IS NOT NULL
DROP FUNCTION inventory.get_unit_id_by_unit_name;

GO

CREATE FUNCTION inventory.get_unit_id_by_unit_name(@unit_name national character varying(500))
RETURNS integer
AS

BEGIN
    RETURN
    (
	    SELECT unit_id
	    FROM inventory.units
	    WHERE inventory.units.unit_name = @unit_name
	    AND inventory.units.deleted = 0
    );
END



GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_unit_name_by_unit_id.sql --<--<--
IF OBJECT_ID('inventory.get_unit_name_by_unit_id') IS NOT NULL
DROP FUNCTION inventory.get_unit_name_by_unit_id;

GO

CREATE FUNCTION inventory.get_unit_name_by_unit_id(@unit_id integer)
RETURNS national character varying(1000)
AS

BEGIN
    RETURN
    (
	    SELECT unit_name
	    FROM inventory.units
	    WHERE inventory.units.unit_id = @unit_id
	    AND inventory.units.deleted = 0
    );
END



GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.get_write_off_cost_of_goods_sold.sql --<--<--
IF OBJECT_ID('inventory.get_write_off_cost_of_goods_sold') IS NOT NULL
DROP FUNCTION inventory.get_write_off_cost_of_goods_sold;

GO

CREATE FUNCTION inventory.get_write_off_cost_of_goods_sold(@checkout_id bigint, @item_id integer, @unit_id integer, @quantity integer)
RETURNS decimal(30, 6)
AS
BEGIN
    DECLARE @base_unit_id integer;
    DECLARE @factor decimal(30, 6);

    SET @base_unit_id    = inventory.get_root_unit_id(@unit_id);
    SET @factor          = inventory.convert_unit(@unit_id, @base_unit_id);


    RETURN
    (
	    SELECT
	        SUM((cost_of_goods_sold / base_quantity) * @factor * @quantity)     
	         FROM inventory.checkout_details
	    WHERE checkout_id = @checkout_id
	    AND item_id = @item_id
	);    
END;

--SELECT * FROM inventory.get_write_off_cost_of_goods_sold(7, 3, 1, 1);


GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.is_parent_unit.sql --<--<--
IF OBJECT_ID('inventory.is_parent_unit') IS NOT NULL
DROP FUNCTION inventory.is_parent_unit;

GO

CREATE FUNCTION inventory.is_parent_unit(@parent integer, @child integer)
RETURNS bit
AS      
BEGIN
    DECLARE @rows int;

    IF(@parent!=@child)
    BEGIN
        WITH unit_cte(unit_id) AS 
        (
            SELECT tn.compare_unit_id
            FROM inventory.compound_units AS tn 
            WHERE tn.base_unit_id = @parent
            AND tn.deleted = 0
            UNION ALL
            SELECT
            c.compare_unit_id
            FROM unit_cte AS p, 
            inventory.compound_units AS c 
            WHERE base_unit_id = p.unit_id
        )

        SELECT @rows = COUNT(*) from unit_cte
        WHERE unit_id=@child;

        IF(COALESCE(@rows, 0) > 0)
        BEGIN
            RETURN 1;
        END;
    END;
    RETURN 0;
END;

GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.is_periodic_inventory.sql --<--<--
IF OBJECT_ID('inventory.is_periodic_inventory') IS NOT NULL
DROP FUNCTION inventory.is_periodic_inventory;

GO

CREATE FUNCTION inventory.is_periodic_inventory(@office_id integer)
RETURNS bit
AS
BEGIN
    IF EXISTS(SELECT * FROM inventory.inventory_setup WHERE inventory_system = 'Periodic' AND office_id = @office_id)
    BEGIN
        RETURN 1;
    END;

    RETURN 0;
END;

GO

ALTER FUNCTION finance.is_periodic_inventory(@office_id integer)
RETURNS bit
AS
BEGIN
    RETURN inventory.is_periodic_inventory(@office_id);
END;

GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.is_purchase.sql --<--<--
IF OBJECT_ID('inventory.is_purchase') IS NOT NULL
DROP FUNCTION inventory.is_purchase;

GO

CREATE FUNCTION inventory.is_purchase(@transaction_master_id bigint)
RETURNS bit
AS

BEGIN
    IF EXISTS
    (
        SELECT * FROM finance.transaction_master
        WHERE finance.transaction_master.transaction_master_id = @transaction_master_id
        AND book IN ('Purchase')
    )
    BEGIN
            RETURN 1;
    END;

    RETURN 0;
END;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.is_valid_unit_id.sql --<--<--
IF OBJECT_ID('inventory.is_valid_unit_id') IS NOT NULL
DROP FUNCTION inventory.is_valid_unit_id;

GO

CREATE FUNCTION inventory.is_valid_unit_id(@unit_id integer, @item_id integer)
RETURNS bit
AS

BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inventory.items
        WHERE inventory.items.item_id = @item_id
        AND inventory.get_root_unit_id(@unit_id) = inventory.get_root_unit_id(unit_id)
        AND inventory.items.deleted = 0
    )
    BEGIN
        RETURN 1;
    END;

    RETURN 0;
END;





GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.list_closing_stock.sql --<--<--
IF OBJECT_ID('inventory.list_closing_stock') IS NOT NULL
DROP FUNCTION inventory.list_closing_stock;

GO

CREATE FUNCTION inventory.list_closing_stock
(
    @store_id               integer
)
RETURNS @result TABLE
(
    item_id                 integer,
    item_code national character varying(50),
    item_name               national character varying(1000),
    unit_id                 integer,
    unit_name               national character varying(1000),
    quantity                decimal(30, 6)
)
AS

BEGIN
    DECLARE @temp_closing_stock TABLE
    (
        item_id             integer,
        item_code national character varying(50),
        item_name           national character varying(1000),
        unit_id             integer,
        unit_name           national character varying(1000),
        quantity            decimal(30, 6),
        maintain_inventory  bit
    ) ;

    INSERT INTO @temp_closing_stock(item_id, unit_id, quantity)
    SELECT 
        inventory.verified_checkout_details_view.item_id, 
        inventory.verified_checkout_details_view.base_unit_id,
        SUM(CASE WHEN inventory.verified_checkout_details_view.transaction_type='Dr' THEN inventory.verified_checkout_details_view.base_quantity ELSE inventory.verified_checkout_details_view.base_quantity * -1 END)
    FROM inventory.verified_checkout_details_view
    WHERE inventory.verified_checkout_details_view.store_id = @store_id
    GROUP BY inventory.verified_checkout_details_view.item_id, inventory.verified_checkout_details_view.store_id, inventory.verified_checkout_details_view.base_unit_id;

    UPDATE @temp_closing_stock 
    SET 
        item_code = inventory.items.item_code,
        item_name = inventory.items.item_name,
        maintain_inventory = inventory.items.maintain_inventory
    FROM @temp_closing_stock AS temp_closing_stock
    INNER JOIN inventory.items
    ON temp_closing_stock.item_id = inventory.items.item_id;

    DELETE FROM @temp_closing_stock WHERE maintain_inventory = 0;

    UPDATE @temp_closing_stock 
    SET 
        unit_name = inventory.units.unit_name
    FROM @temp_closing_stock AS temp_closing_stock
    INNER JOIN inventory.units
    ON temp_closing_stock.unit_id = inventory.units.unit_id;

    INSERT INTO @result
    SELECT 
        temp_closing_stock.item_id, 
        temp_closing_stock.item_code, 
        temp_closing_stock.item_name, 
        temp_closing_stock.unit_id, 
        temp_closing_stock.unit_name, 
        temp_closing_stock.quantity
    FROM temp_closing_stock
    ORDER BY item_id;

    RETURN;
END;


--SELECT * FROM inventory.list_closing_stock(1);

GO



-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.post_adjustment.sql --<--<--
IF OBJECT_ID('inventory.post_adjustment') IS NOT NULL
DROP PROCEDURE inventory.post_adjustment;

GO


CREATE PROCEDURE inventory.post_adjustment
(
    @office_id                              integer,
    @user_id                                integer,
    @login_id                               bigint,
    @store_id                               integer,
    @value_date                             date,
    @book_date                              date,
    @reference_number                       national character varying(24),
    @statement_reference                    national character varying(2000),
    @details                                inventory.adjustment_type READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @transaction_master_id          bigint;
    DECLARE @checkout_id                    bigint;
    DECLARE @book_name                      national character varying(1000)='Inventory Adjustment';
    DECLARE @is_periodic                    bit = inventory.is_periodic_inventory(@office_id);
    DECLARE @default_currency_code          national character varying(12);

    DECLARE @can_post_transaction           bit;
    DECLARE @error_message                  national character varying(MAX);

    SELECT
        @can_post_transaction   = can_post_transaction,
        @error_message          = error_message
    FROM finance.can_post_transaction(@login_id, @user_id, @office_id, @book_name, @value_date);

    IF(@can_post_transaction = 0)
    BEGIN
        RAISERROR(@error_message, 10, 1);
        RETURN;
    END;
    
    DECLARE @temp_stock_details TABLE
    (
        tran_type                       national character varying(2),
        store_id                        integer,
        item_id                         integer,
        item_code                       national character varying(12),
        unit_id                         integer,
        base_unit_id                    integer,
        unit_name                       national character varying(50),
        quantity                        decimal(30, 6),
        base_quantity                   decimal(30, 6),                
        price                           decimal(30, 6),
        cost_of_goods_sold              decimal(30, 6) DEFAULT(0),
        inventory_account_id            integer,
        cost_of_goods_sold_account_id   integer
    ) 
    ; 

    DECLARE @temp_transaction_details TABLE
    (
        tran_type                   national character varying(2), 
        account_id                  integer, 
        statement_reference         national character varying(2000), 
        cash_repository_id          integer, 
        currency_code               national character varying(12), 
        amount_in_currency          decimal(30, 6), 
        local_currency_code         national character varying(12), 
        er                          decimal(30, 6), 
        amount_in_local_currency    decimal(30, 6)
    ) ;

    INSERT INTO @temp_stock_details(tran_type, store_id, item_code, unit_name, quantity)
    SELECT tran_type, @store_id, item_code, unit_name, quantity 
    FROM @details;

    IF EXISTS
    (
        SELECT * FROM @temp_stock_details
        WHERE tran_type = 'Dr'
    )
    BEGIN
        RAISERROR('A stock adjustment entry can not contain debit item(s).', 10, 1);
    END;

    IF EXISTS
    (
        SELECT 1 FROM @temp_stock_details
        GROUP BY item_code
        HAVING COUNT(item_code) <> 1
    )
    BEGIN
        RAISERROR('An item can appear only once in a store.', 10, 1);
    END;

    UPDATE @temp_stock_details 
    SET 
        item_id         = inventory.get_item_id_by_item_code(item_code),
        unit_id         = inventory.get_unit_id_by_unit_name(unit_name);

    IF EXISTS
    (
        SELECT * FROM @temp_stock_details
        WHERE item_id IS NULL OR unit_id IS NULL OR store_id IS NULL
    )
    BEGIN
        RAISERROR('Invalid data supplied.', 10, 1);
    END;

    UPDATE @temp_stock_details 
    SET
        tran_type                       = 'Cr',
        base_quantity                   = inventory.get_base_quantity_by_unit_id(unit_id, quantity),
        base_unit_id                    = inventory.get_root_unit_id(unit_id),
        price                           = inventory.get_item_cost_price(item_id, unit_id),
        inventory_account_id            = inventory.get_inventory_account_id(item_id),
        cost_of_goods_sold_account_id   = inventory.get_cost_of_goods_sold_account_id(item_id);


    IF EXISTS
    (
            SELECT 1
            FROM 
            inventory.stores
            WHERE inventory.stores.store_id
            IN
            (
                SELECT store_id
                FROM @temp_stock_details
            )
            HAVING COUNT(DISTINCT inventory.stores.office_id) > 1

    )
    BEGIN
        RAISERROR('Access is denied!\nA stock adjustment transaction cannot references multiple branches.', 10, 1);
    END;

    IF EXISTS
    (
            SELECT 1
            FROM 
            @temp_stock_details
            WHERE tran_type = 'Cr'
            AND quantity > inventory.count_item_in_stock(item_id, unit_id, store_id)
    )
    BEGIN
        RAISERROR('Negative stock is not allowed.', 10, 1);
    END;

    --No accounting treatment is needed for periodic accounting system.
    IF(@is_periodic = 0)
    BEGIN
        SET @default_currency_code  = core.get_currency_code_by_office_id(@office_id);

        UPDATE @temp_stock_details 
        SET 
            cost_of_goods_sold = inventory.get_cost_of_goods_sold(item_id, unit_id, store_id, quantity);
    
        INSERT INTO @temp_transaction_details(tran_type, account_id, statement_reference, currency_code, amount_in_currency, er, local_currency_code, amount_in_local_currency)
        SELECT 'Dr', cost_of_goods_sold_account_id, @statement_reference, @default_currency_code, SUM(COALESCE(cost_of_goods_sold, 0)), 1, @default_currency_code, SUM(COALESCE(cost_of_goods_sold, 0))
        FROM @temp_stock_details
        GROUP BY cost_of_goods_sold_account_id;

        INSERT INTO @temp_transaction_details(tran_type, account_id, statement_reference, currency_code, amount_in_currency, er, local_currency_code, amount_in_local_currency)
        SELECT 'Cr', inventory_account_id, @statement_reference, @default_currency_code, SUM(COALESCE(cost_of_goods_sold, 0)), 1, @default_currency_code, SUM(COALESCE(cost_of_goods_sold, 0))
        FROM @temp_stock_details
        GROUP BY inventory_account_id;
    END;
    
    INSERT INTO finance.transaction_master
    (
        transaction_counter,
        transaction_code,
        book,
        value_date,
        book_date,
        login_id,
        user_id,
        office_id,
        reference_number,
        statement_reference
    )
    SELECT
        finance.get_new_transaction_counter(@value_date), 
        finance.get_transaction_code(@value_date, @office_id, @user_id, @login_id),
        @book_name,
        @value_date,
        @book_date,
        @login_id,
        @user_id,
        @office_id,
        @reference_number,
        @statement_reference;

    SET @transaction_master_id = SCOPE_IDENTITY();

    INSERT INTO finance.transaction_details(office_id, value_date, book_date, transaction_master_id, tran_type, account_id, statement_reference, cash_repository_id, currency_code, amount_in_currency, local_currency_code, er, amount_in_local_currency)
    SELECT @office_id, @value_date, @book_date, @transaction_master_id, tran_type, account_id, statement_reference, cash_repository_id, currency_code, amount_in_currency, local_currency_code, er, amount_in_local_currency
    FROM @temp_transaction_details
    ORDER BY tran_type DESC;



    INSERT INTO inventory.checkouts(transaction_master_id, value_date, book_date, transaction_book, posted_by, office_id)
    SELECT @transaction_master_id, @value_date, @book_date, @book_name, @user_id, @office_id;

    SET @checkout_id                = SCOPE_IDENTITY();


    INSERT INTO inventory.checkout_details(checkout_id, value_date, book_date, transaction_type, store_id, item_id, quantity, unit_id, base_quantity, base_unit_id, price)
    SELECT @checkout_id, @value_date, @book_date, tran_type, store_id, item_id, quantity, unit_id, base_quantity, base_unit_id, price
    FROM @temp_stock_details;

    EXECUTE finance.auto_verify @transaction_master_id, @office_id;
    
    SELECT @transaction_master_id;
END;




-- SELECT * FROM inventory.post_adjustment(1, 1, 1, 1, CAST(GETDATE() AS date), CAST(GETDATE() AS date), '22', 'Test', 
-- ARRAY[
-- ROW('Cr', 'RMBP', 'Piece', 1),
-- ROW('Cr', '11MBA', 'Piece', 1)
-- ]
-- );



GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.post_opening_inventory.sql --<--<--
IF OBJECT_ID('inventory.post_opening_inventory') IS NOT NULL
DROP PROCEDURE inventory.post_opening_inventory;

GO

CREATE PROCEDURE inventory.post_opening_inventory
(
    @office_id                              integer,
    @user_id                                integer,
    @login_id                               bigint,
    @value_date                             date,
    @book_date                              date,
    @reference_number                       national character varying(24),
    @statement_reference                    national character varying(2000),
    @details                                inventory.opening_stock_type READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @book_name                      national character varying(1000) = 'Opening Inventory';
    DECLARE @transaction_master_id          bigint;
    DECLARE @checkout_id                bigint;
    DECLARE @tran_counter                   integer;
    DECLARE @transaction_code national character varying(50);

    DECLARE @can_post_transaction           bit;
    DECLARE @error_message                  national character varying(MAX);

    SELECT
        @can_post_transaction   = can_post_transaction,
        @error_message          = error_message
    FROM finance.can_post_transaction(@login_id, @user_id, @office_id, @book_name, @value_date);

    IF(@can_post_transaction = 0)
    BEGIN
        RAISERROR(@error_message, 10, 1);
        RETURN;
    END;
    
    DECLARE @temp_stock_details TABLE
    (
        id                              integer IDENTITY PRIMARY KEY,
        tran_type                       national character varying(2),
        store_id                        integer,
        item_id                         integer, 
        quantity                        decimal(30, 6),
        unit_id                         integer,
        base_quantity                   decimal(30, 6),
        base_unit_id                    integer,                
        price                           decimal(30, 6)
    ) ;

    INSERT INTO @temp_stock_details(store_id, item_id, quantity, unit_id, price)
    SELECT store_id, item_id, quantity, unit_id, price
    FROM @details;

    UPDATE @temp_stock_details 
    SET
        tran_type                       = 'Dr',
        base_quantity                   = inventory.get_base_quantity_by_unit_id(unit_id, quantity),
        base_unit_id                    = inventory.get_root_unit_id(unit_id);

    IF EXISTS
    (
        SELECT * FROM @temp_stock_details
        WHERE store_id IS NULL
        OR item_id IS NULL
        OR unit_id IS NULL
    )
    BEGIN
        RAISERROR('Access is denied. Invalid values supplied.', 10, 1);
    END;

    IF EXISTS
    (
        SELECT TOP 1 0 FROM @temp_stock_details AS details
        WHERE inventory.is_valid_unit_id(details.unit_id, details.item_id) = 0
    )
    BEGIN
        RAISERROR('Item/unit mismatch.', 10, 1);
    END;

    
    SET @tran_counter           = finance.get_new_transaction_counter(@value_date);
    SET @transaction_code       = finance.get_transaction_code(@value_date, @office_id, @user_id, @login_id);


    INSERT INTO finance.transaction_master(transaction_counter, transaction_code, book, value_date, book_date, user_id, login_id, office_id, reference_number, statement_reference) 
    SELECT @tran_counter, @transaction_code, @book_name, @value_date, @book_date, @user_id, @login_id, @office_id, @reference_number, @statement_reference;
    SET @transaction_master_id = SCOPE_IDENTITY();


    INSERT INTO inventory.checkouts(transaction_book, value_date, book_date, checkout_id, transaction_master_id, posted_by, office_id)
    SELECT @book_name, @value_date, @book_date, @checkout_id, @transaction_master_id, @user_id, @office_id;
    SET @transaction_master_id = SCOPE_IDENTITY();


    INSERT INTO inventory.checkout_details(value_date, book_date, checkout_id, transaction_type, store_id, item_id, quantity, unit_id, base_quantity, base_unit_id, price)
    SELECT @value_date, @book_date, @checkout_id, tran_type, store_id, item_id, quantity, unit_id, base_quantity, base_unit_id, price
    FROM @temp_stock_details;
    
    EXECUTE finance.auto_verify @transaction_master_id, @office_id;    
    SELECT @transaction_master_id;
END;



-- 
-- SELECT * FROM inventory.post_opening_inventory
-- (
--     2,
--     2,
--     5,
--     '1-1-2020',
--     '1-1-2020',
--     '3424',
--     'ASDF',
--     ARRAY[
--          ROW(1, 1, 1, 1,180000),
--          ROW(1, 2, 1, 1,130000),
--          ROW(1, 3, 1, 1,110000)]);
-- 


GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/02.functions-and-logic/inventory.post_transfer.sql --<--<--
IF OBJECT_ID('inventory.post_transfer') IS NOT NULL
DROP PROCEDURE inventory.post_transfer;

GO


CREATE PROCEDURE inventory.post_transfer
(
    @office_id                              integer,
    @user_id                                integer,
    @login_id                               bigint,
    @value_date                             date,
    @book_date                              date,
    @reference_number                       national character varying(24),
    @statement_reference                    national character varying(2000),
    @details                                inventory.transfer_type READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @transaction_master_id          bigint;
    DECLARE @checkout_id                    bigint;
    DECLARE @book_name                      national character varying(1000)='Inventory Transfer';

    DECLARE @can_post_transaction           bit;
    DECLARE @error_message                  national character varying(MAX);

    SELECT
        @can_post_transaction   = can_post_transaction,
        @error_message          = error_message
    FROM finance.can_post_transaction(@login_id, @user_id, @office_id, @book_name, @value_date);

    IF(@can_post_transaction = 0)
    BEGIN
        RAISERROR(@error_message, 10, 1);
        RETURN;
    END;

    DECLARE @temp_stock_details TABLE
    (
        tran_type       national character varying(2),
        store_id        integer,
        store_name      national character varying(50),
        item_id         integer,
        item_code       national character varying(12),
        unit_id         integer,
        base_unit_id    integer,
        unit_name       national character varying(50),
        quantity        decimal(30, 6),
        base_quantity   decimal(30, 6),                
        price           decimal(30, 6)
    ) 
    ; 

    INSERT INTO @temp_stock_details(tran_type, store_name, item_code, unit_name, quantity, price)
    SELECT tran_type, store_name, item_code, unit_name, quantity, rate * quantity
    FROM @details;

    IF EXISTS
    (
        SELECT 1 FROM @temp_stock_details
        GROUP BY item_code, store_name
        HAVING COUNT(item_code) <> 1
    )
    BEGIN
        RAISERROR('An item can appear only once in a store.', 10, 1);
    END;

    UPDATE @temp_stock_details SET 
    item_id         = inventory.get_item_id_by_item_code(item_code),
    unit_id         = inventory.get_unit_id_by_unit_name(unit_name),
    store_id        = inventory.get_store_id_by_store_name(store_name);

    IF EXISTS
    (
        SELECT * FROM @temp_stock_details
        WHERE item_id IS NULL OR unit_id IS NULL OR store_id IS NULL
    )
    BEGIN
        RAISERROR('Invalid data supplied.', 10, 1);
    END;

    UPDATE @temp_stock_details 
    SET
        base_unit_id    = inventory.get_root_unit_id(unit_id),
        base_quantity   = inventory.get_base_quantity_by_unit_id(unit_id, quantity);

    UPDATE @temp_stock_details 
    SET
        price           = inventory.get_item_cost_price(item_id, unit_id)
    WHERE price IS NULL;

    IF EXISTS
    (
        SELECT item_code FROM @temp_stock_details
        GROUP BY item_code
        HAVING SUM(CASE WHEN tran_type='Dr' THEN base_quantity ELSE base_quantity *-1 END) <> 0
    )
    BEGIN
        RAISERROR('Referencing sides are not equal.', 10, 1);
    END;


    IF EXISTS
    (
            SELECT 1
            FROM 
            inventory.stores
            WHERE inventory.stores.store_id
            IN
            (
                SELECT store_id
                FROM @temp_stock_details
            )
            HAVING COUNT(DISTINCT inventory.stores.office_id) > 1

    )
    BEGIN
        RAISERROR('Access is denied!\nA stock journal transaction cannot references multiple branches.', 10, 1);
    END;

    IF EXISTS
    (
            SELECT 1
            FROM 
            @temp_stock_details
            WHERE tran_type = 'Cr'
            AND quantity > inventory.count_item_in_stock(item_id, unit_id, store_id)
    )
    BEGIN
        RAISERROR('Negative stock is not allowed.', 10, 1);
    END;

    INSERT INTO finance.transaction_master(transaction_counter, transaction_code, book, value_date, book_date, login_id, user_id, office_id, reference_number, statement_reference)
    SELECT
        finance.get_new_transaction_counter(@value_date), 
        finance.get_transaction_code(@value_date, @office_id, @user_id, @login_id),
        @book_name,
        @value_date,
        @book_date,
        @login_id,
        @user_id,
        @office_id,
        @reference_number,
        @statement_reference;

    SET @transaction_master_id = SCOPE_IDENTITY();


    INSERT INTO inventory.checkouts(transaction_master_id, transaction_book, value_date, book_date, posted_by, office_id)
    SELECT @transaction_master_id, @book_name, @value_date, @book_date, @user_id, @office_id;
    SET @checkout_id                = SCOPE_IDENTITY();

    INSERT INTO inventory.checkout_details(checkout_id, value_date, book_date, transaction_type, store_id, item_id, quantity, unit_id, base_quantity, base_unit_id, price)
    SELECT @checkout_id, @value_date, @book_date, tran_type, store_id, item_id, quantity, unit_id, base_quantity, base_unit_id, price
    FROM @temp_stock_details;
    
    
    EXECUTE finance.auto_verify @transaction_master_id, @office_id;
    SELECT @transaction_master_id;
END;




-- SELECT * FROM inventory.post_transfer(1, 1, 1, '1-1-2020', '1-1-2020', '22', 'Test', 
-- ARRAY[
-- ROW('Cr', 'Store 1', 'RMBP', 'Dozen', 2),
-- ROW('Dr', 'down 1', 'RMBP', 'Piece', 24)
-- ]
-- );




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/03.menus/menus.sql --<--<--
DELETE FROM auth.menu_access_policy
WHERE menu_id IN
(
    SELECT menu_id FROM core.menus
    WHERE app_name = 'Inventory'
);

DELETE FROM auth.group_menu_access_policy
WHERE menu_id IN
(
    SELECT menu_id FROM core.menus
    WHERE app_name = 'Inventory'
);

DELETE FROM core.menus
WHERE app_name = 'Inventory';


EXECUTE core.create_app 'Inventory', 'Inventory', '1.0', 'MixERP Inc.', 'December 1, 2015', 'cart teal', '/dashboard/inventory/tasks/inventory-transfers', NULL;

EXECUTE core.create_menu 'Inventory', 'Tasks', '', 'lightning', '';
EXECUTE core.create_menu 'Inventory', 'Inventory Transfers', '/dashboard/inventory/tasks/inventory-transfers', 'exchange', 'Tasks';
EXECUTE core.create_menu 'Inventory', 'Inventory Adjustments', '/dashboard/inventory/tasks/inventory-adjustments', 'grid layout', 'Tasks';
EXECUTE core.create_menu 'Inventory', 'Inventory Transfer Verification', '/dashboard/inventory/tasks/inventory-transfers/verification', 'checkmark box', 'Tasks';
EXECUTE core.create_menu 'Inventory', 'Inventory Adjustment Verification', '/dashboard/inventory/tasks/inventory-adjustments/verification', 'checkmark', 'Tasks';
-- EXECUTE core.create_menu 'Inventory', 'Inventory Transfer Request', '/dashboard/inventory/tasks/inventory-transfer/request', 'food', 'Tasks';
-- EXECUTE core.create_menu 'Inventory', 'Inventory Transfer Authorization', '/dashboard/inventory/tasks/inventory-transfer/authorization', 'keyboard', 'Tasks';
-- EXECUTE core.create_menu 'Inventory', 'Inventory Transfer Delivery', '/dashboard/inventory/tasks/inventory-transfer/delivery', 'users', 'Tasks';
-- EXECUTE core.create_menu 'Inventory', 'Inventory Transfer Acknowledgement', '/dashboard/inventory/tasks/inventory-transfer/acknowledgement', 'users', 'Tasks';
-- EXECUTE core.create_menu 'Inventory', 'Inventory Transfer Acknowledgement', '/dashboard/inventory/tasks/inventory-transfer/acknowledgement', 'users', 'Tasks';

EXECUTE core.create_menu 'Inventory', 'Setup', 'square outline', 'configure', '';
EXECUTE core.create_menu 'Inventory', 'Inventory Items', '/dashboard/inventory/setup/inventory-items', 'content', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Item Groups', '/dashboard/inventory/setup/item-groups', 'cubes', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Item Types', '/dashboard/inventory/setup/item-types', 'ellipsis vertical', 'Setup';
--EXECUTE core.create_menu 'Inventory', 'Cost Prices', '/dashboard/inventory/setup/cost-prices', 'money', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Store Types', '/dashboard/inventory/setup/store-types', 'block layout', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Stores', '/dashboard/inventory/setup/stores', 'cube', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Counters', '/dashboard/inventory/setup/counters', 'square outline', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Customer Types', '/dashboard/inventory/setup/customer-types', 'users', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Supplier Types', '/dashboard/inventory/setup/supplier-types', 'spy', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Customers', '/dashboard/inventory/setup/customers', 'user', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Suppliers', '/dashboard/inventory/setup/suppliers', 'male', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Brands', '/dashboard/inventory/setup/brands', 'bold', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Units of Measure', '/dashboard/inventory/setup/units-of-measure', 'underline', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Compound Units of Measure', '/dashboard/inventory/setup/compound-units-of-measure', 'move', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Shippers', '/dashboard/inventory/setup/shippers', 'ship', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Attributes', '/dashboard/inventory/setup/attributes', 'crosshairs', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Variants', '/dashboard/inventory/setup/variants', 'align center', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Item Variants', '/dashboard/inventory/setup/item-variants', 'unordered list', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Opening Inventory', '/dashboard/inventory/setup/opening-inventory', 'toggle on', 'Setup';
EXECUTE core.create_menu 'Inventory', 'Opening Inventory Verification', '/dashboard/inventory/setup/opening-inventory/verification', 'check circle outline', 'Setup';

EXECUTE core.create_menu 'Inventory', 'Reports', '', 'block layout', '';
EXECUTE core.create_menu 'Inventory', 'Inventory Account Statement', '/dashboard/reports/view/Areas/MixERP.Inventory/Reports/AccountStatement.xml', 'book', 'Reports';



DECLARE @office_id integer = core.get_office_id_by_office_name('Default');
EXECUTE auth.create_app_menu_policy
'Admin', 
@office_id, 
'Inventory',
'{*}';

GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/04.default-values/01.default-values.sql --<--<--
INSERT INTO inventory.inventory_setup(office_id, inventory_system, cogs_calculation_method, default_discount_account_id)
SELECT office_id, 'Perpetual', 'FIFO', finance.get_account_id_by_account_number('40270')
FROM core.offices;


GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/05.scrud-views/inventory.customer_scrud_view.sql --<--<--
IF OBJECT_ID('inventory.customer_scrud_view') IS NOT NULL
DROP VIEW inventory.customer_scrud_view;

GO



CREATE VIEW inventory.customer_scrud_view
AS
SELECT
    inventory.customers.customer_id,
    inventory.customers.customer_code,
    inventory.customers.customer_name,
    inventory.customer_types.customer_type_code + ' (' + inventory.customer_types.customer_type_name + ')' AS customer_type,
    inventory.customers.currency_code,
    inventory.customers.company_name,
    inventory.customers.company_phone_numbers,
    inventory.customers.contact_first_name,
    inventory.customers.contact_middle_name,
    inventory.customers.contact_last_name,
    inventory.customers.contact_phone_numbers,
    inventory.customers.photo
FROM inventory.customers
INNER JOIN inventory.customer_types
ON inventory.customer_types.customer_type_id = inventory.customers.customer_type_id;


GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/05.scrud-views/inventory.item_scrud_view.sql --<--<--
IF OBJECT_ID('inventory.item_scrud_view') IS NOT NULL
DROP VIEW inventory.item_scrud_view;

GO



CREATE VIEW inventory.item_scrud_view
AS
SELECT
    inventory.items.item_id,
    inventory.items.item_code,
    inventory.items.item_name,
    inventory.items.barcode,
    inventory.items.item_group_id,
    inventory.item_groups.item_group_name,
    inventory.item_types.item_type_id,
    inventory.item_types.item_type_name,
    inventory.items.brand_id,
    inventory.brands.brand_name,
    inventory.items.preferred_supplier_id,
    inventory.items.unit_id,
    inventory.units.unit_code,
    inventory.units.unit_name,
    inventory.items.hot_item,
    inventory.items.cost_price,
    inventory.items.selling_price,
    inventory.items.maintain_inventory,
    inventory.items.allow_sales,
    inventory.items.allow_purchase,
    inventory.items.photo
FROM inventory.items
INNER JOIN inventory.item_groups
ON inventory.item_groups.item_group_id = inventory.items.item_group_id
INNER JOIN inventory.item_types
ON inventory.item_types.item_type_id = inventory.items.item_type_id
INNER JOIN inventory.brands
ON inventory.brands.brand_id = inventory.items.brand_id
INNER JOIN inventory.units
ON inventory.units.unit_id = inventory.items.unit_id
WHERE inventory.items.deleted = 0
AND inventory.items.allow_purchase = 1
AND inventory.items.maintain_inventory = 1;



GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/05.views/inventory.checkout_detail_view.sql --<--<--
IF OBJECT_ID('inventory.checkout_detail_view') IS NOT NULL
DROP VIEW inventory.checkout_detail_view;

GO



CREATE VIEW inventory.checkout_detail_view
AS
SELECT
    inventory.checkouts.transaction_master_id,
    inventory.checkouts.checkout_id,
    inventory.checkout_details.checkout_detail_id,
    inventory.checkout_details.transaction_type,
    inventory.checkout_details.store_id,
    inventory.stores.store_code,
    inventory.stores.store_name,
    inventory.checkout_details.item_id,
    inventory.items.is_taxable_item,
    inventory.items.item_code,
    inventory.items.item_name,
    inventory.checkout_details.quantity,
    inventory.checkout_details.unit_id,
    inventory.units.unit_code,
    inventory.units.unit_name,
    inventory.checkout_details.base_quantity,
    inventory.checkout_details.base_unit_id,
    base_unit.unit_code AS base_unit_code,
    base_unit.unit_name AS base_unit_name,
    inventory.checkout_details.price,
    inventory.checkout_details.discount,
    inventory.checkout_details.tax,
    inventory.checkout_details.shipping_charge,
    (inventory.checkout_details.price * inventory.checkout_details.quantity) 
    + COALESCE(inventory.checkout_details.shipping_charge, 0)
    - COALESCE(inventory.checkout_details.discount, 0) AS amount,
    (inventory.checkout_details.price * inventory.checkout_details.quantity) 
    + COALESCE(inventory.checkout_details.tax, 0) 
    + COALESCE(inventory.checkout_details.shipping_charge, 0)
    - COALESCE(inventory.checkout_details.discount, 0) AS total
FROM inventory.checkout_details
INNER JOIN inventory.checkouts
ON inventory.checkouts.checkout_id = inventory.checkout_details.checkout_id
INNER JOIN inventory.stores
ON inventory.stores.store_id = inventory.checkout_details.store_id
INNER JOIN inventory.items
ON inventory.items.item_id = inventory.checkout_details.item_id
INNER JOIN inventory.units
ON inventory.units.unit_id = inventory.checkout_details.unit_id
INNER JOIN inventory.units AS base_unit
ON base_unit.unit_id = inventory.checkout_details.base_unit_id;


GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/05.views/inventory.checkout_view.sql --<--<--
IF OBJECT_ID('inventory.checkout_view') IS NOT NULL
DROP VIEW inventory.checkout_view-- CASCADE;

GO



CREATE VIEW inventory.checkout_view
AS
SELECT
    finance.transaction_master.transaction_master_id,
    inventory.checkouts.checkout_id,
    inventory.checkout_details.checkout_detail_id,
    finance.transaction_master.book,
    finance.transaction_master.transaction_counter,
    finance.transaction_master.transaction_code,
    finance.transaction_master.value_date,
    finance.transaction_master.transaction_ts,
    finance.transaction_master.login_id,
    finance.transaction_master.user_id,
    finance.transaction_master.office_id,
    finance.transaction_master.cost_center_id,
    finance.transaction_master.reference_number,
    finance.transaction_master.statement_reference,
    finance.transaction_master.last_verified_on,
    finance.transaction_master.verified_by_user_id,
    finance.transaction_master.verification_status_id,
    finance.transaction_master.verification_reason,
    inventory.checkout_details.transaction_type,
    inventory.checkout_details.store_id,
    inventory.checkout_details.item_id,
    inventory.checkout_details.quantity,
    inventory.checkout_details.unit_id,
    inventory.checkout_details.base_quantity,
    inventory.checkout_details.base_unit_id,
    inventory.checkout_details.price,
    inventory.checkout_details.discount,
    inventory.checkout_details.tax,
    inventory.checkout_details.shipping_charge,
    (
        inventory.checkout_details.price 
        - inventory.checkout_details.discount 
        + COALESCE(inventory.checkout_details.tax, 0)
        + COALESCE(inventory.checkout_details.shipping_charge, 0)
    ) * inventory.checkout_details.quantity AS amount
FROM inventory.checkout_details
INNER JOIN inventory.checkouts
ON inventory.checkouts.checkout_id = inventory.checkout_details.checkout_id
INNER JOIN finance.transaction_master
ON finance.transaction_master.transaction_master_id = inventory.checkouts.transaction_master_id;




GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/05.views/inventory.item_view.sql --<--<--
IF OBJECT_ID('inventory.item_view') IS NOT NULL
DROP VIEW inventory.item_view;

GO



CREATE VIEW inventory.item_view
AS
SELECT
    inventory.items.item_id,
    inventory.items.item_code,
    inventory.items.item_name,
    inventory.items.is_taxable_item,
    inventory.items.barcode,
    inventory.items.item_group_id,
    inventory.item_groups.item_group_name,
    inventory.item_types.item_type_id,
    inventory.item_types.item_type_name,
    inventory.items.brand_id,
    inventory.brands.brand_name,
    inventory.items.preferred_supplier_id,
    inventory.items.unit_id,
    inventory.get_associated_unit_list_csv(inventory.items.unit_id) AS valid_units,
    inventory.units.unit_code,
    inventory.units.unit_name,
    inventory.items.hot_item,
    inventory.items.cost_price,
    inventory.items.cost_price_includes_tax,
    inventory.items.selling_price,
    inventory.items.selling_price_includes_tax,
    inventory.items.photo,
    inventory.items.maintain_inventory
FROM inventory.items
INNER JOIN inventory.item_groups
ON inventory.item_groups.item_group_id = inventory.items.item_group_id
INNER JOIN inventory.item_types
ON inventory.item_types.item_type_id = inventory.items.item_type_id
INNER JOIN inventory.brands
ON inventory.brands.brand_id = inventory.items.brand_id
INNER JOIN inventory.units
ON inventory.units.unit_id = inventory.items.unit_id
WHERE inventory.items.deleted = 0;

GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/05.views/inventory.verified_checkout_details_view.sql --<--<--
IF OBJECT_ID('inventory.verified_checkout_details_view') IS NOT NULL
DROP VIEW inventory.verified_checkout_details_view;

GO



CREATE VIEW inventory.verified_checkout_details_view
AS
SELECT inventory.checkout_details.* 
FROM inventory.checkout_details
INNER JOIN inventory.checkouts
ON inventory.checkouts.checkout_id = inventory.checkout_details.checkout_id
INNER JOIN finance.transaction_master
ON finance.transaction_master.transaction_master_id = inventory.checkouts.transaction_master_id
AND finance.transaction_master.verification_status_id > 0;


GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/05.views/inventory.verified_checkout_view.sql --<--<--
IF OBJECT_ID('inventory.verified_checkout_view') IS NOT NULL
DROP VIEW inventory.verified_checkout_view;

GO

CREATE VIEW inventory.verified_checkout_view
AS
SELECT * FROM inventory.checkout_view
WHERE verification_status_id > 0;

GO


-->-->-- src/Frapid.Web/Areas/MixERP.Inventory/db/SQL Server/2.x/2.0/src/99.ownership.sql --<--<--
EXEC sp_addrolemember  @rolename = 'db_owner', @membername  = 'frapid_db_user'


EXEC sp_addrolemember  @rolename = 'db_datareader', @membername  = 'report_user'


GO


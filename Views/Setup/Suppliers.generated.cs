﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ASP
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Net;
    using System.Text;
    using System.Web;
    using System.Web.Helpers;
    using System.Web.Mvc;
    using System.Web.Mvc.Ajax;
    using System.Web.Mvc.Html;
    using System.Web.Routing;
    using System.Web.Security;
    using System.Web.UI;
    using System.Web.WebPages;
    using Frapid.Configuration;
    using Frapid.Dashboard;
    using Frapid.DataAccess;
    using Frapid.DbPolicy;
    using Frapid.Framework;
    using Frapid.i18n;
    using Frapid.Messaging;
    using Frapid.WebsiteBuilder;
    using MixERP.Inventory;
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("RazorGenerator", "2.0.0.0")]
    [System.Web.WebPages.PageVirtualPathAttribute("~/Views/Setup/Suppliers.cshtml")]
    public partial class _Views_Setup_Suppliers_cshtml : System.Web.Mvc.WebViewPage<dynamic>
    {
        public _Views_Setup_Suppliers_cshtml()
        {
        }
        public override void Execute()
        {
            
            #line 3 "..\..\Views\Setup\Suppliers.cshtml"
  
    ViewBag.Title = "Suppliers";
    Layout = ViewBag.Layout;

            
            #line default
            #line hidden
WriteLiteral("\r\n\r\n<script>\r\n    var scrudFactory = new Object();\r\n\r\n    scrudFactory.title = \"S" +
"uppliers\";\r\n\r\n    scrudFactory.viewAPI = \"/api/forms/inventory/suppliers\";\r\n    " +
"scrudFactory.viewTableName = \"inventory.suppliers\";\r\n\r\n    scrudFactory.formAPI " +
"= \"/api/forms/inventory/suppliers\";\r\n    scrudFactory.formTableName = \"inventory" +
".suppliers\";\r\n\r\n    scrudFactory.excludedColumns = [\"audit_user_id\", \"audit_ts\"]" +
";\r\n\r\n    scrudFactory.allowDelete = true;\r\n    scrudFactory.allowEdit = true;\r\n\r" +
"\n    scrudFactory.live = \"SupplierName\";\r\n    scrudFactory.uploadHanlder = \"/das" +
"hboard/inventory/services/attachments\";\r\n\r\n    scrudFactory.card = {\r\n        im" +
"age: \"Photo\",\r\n        header: \"SupplierName\",\r\n        meta: \"SupplierCode\",\r\n " +
"       description: \"ContactPhoneNumbers\"        \r\n    };\r\n\r\n    scrudFactory.la" +
"yout = [\r\n        {\r\n            tab: \"\",\r\n            fields: [\r\n              " +
"  [\"SupplierId\", \"\"],\r\n                [\"Photo\", \"\"],\r\n                [\"Supplie" +
"rCode\", \"SupplierName\"],\r\n                [\"SupplierTypeId\", \"\"],\r\n             " +
"   [\"Logo\", \"\"]\r\n            ]\r\n        }\r\n    ];\r\n\r\n    scrudFactory.keys = [\r\n" +
"        {\r\n            property: \"SupplierTypeId\",\r\n            url: \'/api/forms" +
"/inventory/supplier-types/display-fields\',\r\n            data: null,\r\n           " +
" valueField: \"Key\",\r\n            textField: \"Value\"\r\n        },\r\n        {\r\n    " +
"        property: \"AccountId\",\r\n            url: \'/api/views/finance/payable-acc" +
"ount-selector-view/display-fields\',\r\n            data: null,\r\n            valueF" +
"ield: \"Key\",\r\n            textField: \"Value\"\r\n        },\r\n        {\r\n           " +
" property: \"CurrencyCode\",\r\n            url: \'/api/views/core/currencies/lookup-" +
"fields\',\r\n            data: null,\r\n            valueField: \"Key\",\r\n            t" +
"extField: \"Value\"\r\n        }\r\n    ];\r\n\r\n\r\n\r\n    $.get(\'/ScrudFactory/View.html\'," +
" function (view) {\r\n        $.get(\'/ScrudFactory/Form.html\', function (form) {\r\n" +
"            $(\"#ScrudFactoryView\").html(view);\r\n            $(\"#ScrudFactoryForm" +
"\").html(form);\r\n            $.cachedScript(\"/assets/js/scrudfactory-view.js\");\r\n" +
"            $.cachedScript(\"/assets/js/scrudfactory-form.js\");\r\n        });\r\n   " +
" });\r\n</script>\r\n\r\n<div");

WriteLiteral(" id=\"ScrudFactoryForm\"");

WriteLiteral("></div>\r\n<div");

WriteLiteral(" id=\"ScrudFactoryView\"");

WriteLiteral("></div>");

        }
    }
}
#pragma warning restore 1591

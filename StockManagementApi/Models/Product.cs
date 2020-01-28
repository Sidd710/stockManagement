using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
    public class Product
    {
        public int Product_ID { get; set; }
        public string Product_Name { get; set; }
        public string Product_Desc { get; set; }
        public string Short_Product_Desc { get; set; }
        public string Admin_Remarks { get; set; }
        public float product_cost { get; set; }
        public string Product_Code { get; set; }
        public int Category_Id { get; set; }
        public DateTime AddedOn { get; set; }
        public DateTime MfgDate { get; set; }
        public DateTime ExpDate { get; set; }
        public string AddedBy { get; set; }
        public DateTime ModifiedOn { get; set; }
        public int ModifiedBy { get; set; }
        public bool IsActive { get; set; }
        public decimal StockQty { get; set; }
        public string IsProductStatus { get; set; }
        public string Cat { get; set; }
        public string productUnit { get; set; }
        public int GSreservre { get; set; }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
    public class ProductList
    {
        public int Product_ID { get; set; }
        public string Product_Name { get; set; }
        public string Product_Desc { get; set; }
        public string Admin_Remarks { get; set; }
        public int Category_Id { get; set; }
        public bool IsActive { get; set; }
        public decimal StockQty { get; set; }
        public string IsProductStatus { get; set; }
        public string Cat { get; set; }
        public string productUnit { get; set; }
        public int GSreservre { get; set; }
        public DateTime AddedOn { get; set; }
        public string AddedBy { get; set; }
        public DateTime ModifiedOn { get; set; }
        public int ModifiedBy { get; set; }

    }
    public class Product
    {
        public List<ProductList> ProductList { get; set; }
    }
    public class ProductMasterNew
    {
        public List<ProductListNew> ProductListNew { get; set; }
    }
    public class ProductListNew
    {
        public int? Id { get; set; }
        public int? CatTypeId { get; set; }
        public string VarietyName { get; set; }
        public string Unit { get; set; }
        public bool? IsLot { get; set; }
        public bool? IsActive { get; set; }
        public string GName { get; set; }
        public string speci { get; set; }
        public string GSreservre { get; set; }
        public string AdminComment { get; set; }
        public string ProductDesc { get; set; }
        public DateTime? AddedOn { get; set; }
        public int AddedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
        public int? ModifiedBy { get; set; }

    }
}
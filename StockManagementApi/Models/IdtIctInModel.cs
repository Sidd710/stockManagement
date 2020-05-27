using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
    public class IdtIctInModel
    {
        public firstForm firstForm { get; set; }
        public List<depotValueModel> depotValue { get; set; }
        public List<depotProductValueModel> depotProdcutValueList { get; set; }
    }

    public class firstForm
    {
        public int Id { get; set; }
        public DateTime DateOfEntry { get; set; }
        public string IdtIctType { get; set; }
        public string ReferenceNumber { get; set; }
    }
    public class depotValue
    {
        public List<depotValueModel> depotValueList { get; set; }
    }
    public class depotValueModel
    {
        public int id { get; set; }
        public string value { get; set; }
        public bool Checked { get; set; }
        public string date { get; set; }

    }
    public class depotProdcutValueList
    {
        public List<depotProductValueModel> depotProductList { get; set; }
    }
    public class depotProductValueModel
    {
        public int productId { get; set; }
        public int depotId { get; set; }
        public string quantity { get; set; }
        public string date { get; set; }
        public int IdtIctMasterId { get; set; }
    }
    public class IdtDetails
    {
        public dynamic IdtIcTMaster { get; set; }
        public dynamic IdtIctDetails { get; set; }
    }
}
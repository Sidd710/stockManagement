using Newtonsoft.Json;
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
        public string status { get; set; }
    }

    public class IdtIctOutModel
    {
        public firstForm firstForm { get; set; }
        public List<depotValueModel> depotValue { get; set; }
        public List<depotProductValueModel> depotProdcutValueList { get; set; }
        public List<depotValueModel> unitValue { get; set; }
        public List<unitProductValueModel> unitProductValueList { get; set; }
        public string status { get; set; }
    }

    public class firstForm
    {
        public int Id { get; set; }
        public DateTime DateOfEntry { get; set; }
        public string IdtIctType { get; set; }
        public string ReferenceNumber { get; set; }
        public string Status { get; set; }
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

    public class unitValueModel
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
        [JsonProperty("pid")]
        public int productId { get; set; }
        [JsonProperty("did")]
        public int depotId { get; set; }
        public string quantity { get; set; }
        public string date { get; set; }
        public int IdtIctMasterId { get; set; }
        public string AvailableQuantity { get; set; }
        public DateTime AddedOn { get; set; }
        public DateTime ModifiedOn { get; set; }
        public int Id { get; set; }
    }

    public class unitProductValueModel
    {
        [JsonProperty("pid")]
        public int productId { get; set; }
        [JsonProperty("uid")]
        public int unitId { get; set; }
        public string quantity { get; set; }
        public string date { get; set; }
        public int IdtIctMasterId { get; set; }
        public string AvailableQuantity { get; set; }
        public DateTime AddedOn { get; set; }
        public DateTime ModifiedOn { get; set; }
        public int Id { get; set; }
        [JsonProperty("did")]
        public int depotId { get; set; }
    }
    public class IdtDetails
    {
        public dynamic IdtIcTMaster { get; set; }
        public dynamic IdtIctDetails { get; set; }
    }

    public class EditIdtIctInModel
    {
        public int Id { get; set; }
        public firstForm firstForm { get; set; }
        public List<depotValueModel> depotValue { get; set; }
        public List<depotProductValueModel> depotProdcutValueList { get; set; }
        public string status { get; set; }
    }

    public class EditIdtIctOutModel
    {
        public int Id { get; set; }
        public firstForm firstForm { get; set; }
        public List<depotValueModel> depotValue { get; set; }
        public List<depotProductValueModel> depotProdcutValueList { get; set; }
        public List<depotValueModel> unitValue { get; set; }
        public List<unitProductValueModel> unitProductValueList { get; set; }
        public string status { get; set; }
    }
    public class InData
    {
        public int Id { get; set; }
        public string ReferenceNumber { get; set; }
        public string Type { get; set; }
    }

    public class IdtReferenceData
    {
        public List<InData> ReferenceData { get; set; }
    }
}
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
    public class Stock
    {
        // public int Id { get; set; }
        [JsonProperty("Sid")]
        public int StockInId { get; set; }
        [JsonProperty("Lid")]
        public string LotBatchId { get; set; }
        [JsonProperty("Pid")]
        public int ProductId { get; set; }
        [JsonProperty("Dor")]
        public DateTime DateOfReceipt { get; set; }
        [JsonProperty("Crv")]
        public string CrvNumber { get; set; }
        [JsonProperty("Des")]
        public string Description { get; set; }
        [JsonProperty("Rcf")]
        public string ReceivedFrom { get; set; }
        [JsonProperty("Pmn")]
        public string PackingMaterialName { get; set; }
        [JsonProperty("Omn")]
        public string OriginalManufacture { get; set; }
        [JsonProperty("Gn")]
        public string GenericName { get; set; }
        [JsonProperty("We")]
        public decimal Weight { get; set; }
        [JsonProperty("Aby")]
        public int AddedBy { get; set; }
        [JsonProperty("Abo")]
        public DateTime AddedOn { get; set; }
        //public int ModifiedBy { get; set; }
        //public DateTime ModifiedOn { get; set; }
        [JsonProperty("Is")]
        public Boolean IsActive { get; set; }

    }
    public class Batch
    {
        [JsonProperty("Bid")]
        public int BatchId { get; set; }
        [JsonProperty("Bn")]
        public string BatchName { get; set; }
        [JsonProperty("Qu")]
        public int Quantity { get; set; }
        [JsonProperty("Wsi")]
        public int WarehouseSectionId { get; set; }
        [JsonProperty("Mfg")]
        public DateTime MfgDate { get; set; }
        [JsonProperty("Exp")]
        public DateTime ExpDate { get; set; }
        [JsonProperty("Esl")]
        public DateTime EslDate { get; set; }
        [JsonProperty("Avl")]
        public int AvailableQuantity { get; set; }


    }

    public class ProductQuantity
    {
        [JsonProperty("Id")]
        public int Id { get; set; }
        [JsonProperty("Pid")]
        public int ProductId { get; set; }
        [JsonProperty("Qua")]
        public int Quantity { get; set; }
    }
    public class StockIn
    {
        [JsonProperty("Bt")]
        public List<Batch> Batch { get; set; }
        [JsonProperty("St")]
        public Stock stock { get; set; }
    }
    public class StockOut
    {
        [JsonProperty("Lid")]
        public int LotBatchId { get; set; }
        [JsonProperty("Qua")]
        public int Quantity { get; set; }
        [JsonProperty("Des")]
        public DateTime DateOfDispatch { get; set; }
    }
    public class ViewStockIn
    {
        public int StockInId { get; set; }
        public string LotBatchId { get; set; }
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string CategoryName { get; set; }
        public string Description { get; set; }
        public DateTime DateOfReceipt { get; set; }
        public List<Batch> Batch { get; set; }
    }
}
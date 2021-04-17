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
        public string BatchIdFromMobile { get; set; }
        [JsonProperty("Pid")]
        public int ProductId { get; set; }
        [JsonProperty("Dor")]
        public DateTime RecievedOn { get; set; }
        [JsonProperty("Crv")]
        public string CRVNo { get; set; }
        [JsonProperty("Des")]
        public string Remarks { get; set; }
        [JsonProperty("Rcf")]
        public string RecievedFrom { get; set; }
        [JsonProperty("Pmn")]
        public string PackingMaterial { get; set; }
        [JsonProperty("Omn")]
        public string OriginalManf { get; set; }
        [JsonProperty("Gn")]
        public string GenericName { get; set; }
        [JsonProperty("We")]
        public decimal? Weight { get; set; }
        [JsonProperty("Aby")]
        public int AddedBy { get; set; }
        [JsonProperty("Qua")]
        public int Quantity { get; set; }
        [JsonProperty("Abo")]
        public DateTime AddedOn { get; set; }
        //public int ModifiedBy { get; set; }
        //public DateTime ModifiedOn { get; set; }
        [JsonProperty("Is")]
        public Boolean IsActive { get; set; }
        [JsonProperty("Ifm")]
        public bool IsFromMobile { get; set; }

        [JsonProperty("ICP")]
        public bool IsCP { get; set; }
        [JsonProperty("ILP")]
        public bool IsLP { get; set; }
        [JsonProperty("ILT")]
        public bool IsLT { get; set; }
        [JsonProperty("IIDT")]
        public bool IsIDT { get; set; }


        [JsonProperty("IICT")]
        public bool IsICT { get; set; }

        [JsonProperty("SuId")]
        public int SupplierId { get; set; }
        [JsonProperty("AT")]
        public string ATNo { get; set; }

        [JsonProperty("OSup")]
        public string OtherSupplier { get; set; }
        public string TransferedBy { get; set; }
        [JsonProperty("SS")]
        public bool SampleSent { get; set; }
        [JsonProperty("supNu")]
        public string SupplierNo { get; set; }
        [JsonProperty("depotId")]
        public int? DepotId { get; set; }

        public string ReferenceNumber { get; set; }

        public int? IdtMasterId { get; set; }
        public int? CptMasterId { get; set; }

    }
    public class Batch
    {
        [JsonProperty("Bid")]
        public int BatchId { get; set; }
        [JsonProperty("Bn")]
        public string BatchName { get; set; }
        [JsonProperty("Bc")]
        public string BatchCode { get; set; }
        [JsonProperty("Bnu")]
        public string BatchNo { get; set; }
        [JsonProperty("Qu")]
        public int Quantity { get; set; }
        [JsonProperty("WId")]
        public int WarehouseID { get; set; }
        [JsonProperty("Mfg")]
        public DateTime MfgDate { get; set; }
        [JsonProperty("Exp")]
        public DateTime ExpDate { get; set; }
        [JsonProperty("Esl")]
        public DateTime ESL { get; set; }
        [JsonProperty("Avl")]
        public int AvailableQuantity { get; set; }
        public DateTime AddedOn { get; set; }
       // public int WarehouseID { get; set; }
        public int SectionID { get; set; }



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

        [JsonProperty("SQI")]
        public int StockOutId { get; set; }
        [JsonProperty("Qua")]
        public int Quantity { get; set; }
        [JsonProperty("BID")]
        public int BatchId { get; set; }
        [JsonProperty("PID")]
        public int ProductId { get; set; }
        [JsonProperty("Dos")]
        public DateTime DateOfDispatch { get; set; }
        [JsonProperty("Rem")]
        public string Remarks { get; set; }
        [JsonProperty("Vno")]
        public string VoucherNumber { get; set; }
        [JsonProperty("Sty")]
        public string StockType { get; set; }
        [JsonProperty("IIDT")]
        public bool IsIDT { get; set; }


        [JsonProperty("IICT")]
        public bool IsICT { get; set; }

        [JsonProperty("IAWS")]
        public bool IsAWS { get; set; }
        [JsonProperty("depotId")]
        public int? DepotId { get; set; }
        [JsonProperty("UId")]
        public int? UnitId { get; set; }
        public int? IdtReferenceId { get; set; }
        public string ReferenceNumber { get; set; }


    }
    public class StockOutParameter
    {
        public List<StockOutBatchList> stockOutBatchList { get; set; }
        public StockOut stockOut { get; set; }
    }
    public class StockOutBatchList
    {
        [JsonProperty("BID")]
        public int BID { get; set; }
        [JsonProperty("Qua")]
        public int Quantity { get; set; }
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
        public List<BatchDetails> Batch { get; set; }
        public string CRVNo { get; set; }
        public int Quantity { get; set; }
        public string AccountingUnit { get; set; }
        public bool IsCP { get; set; }
        public bool IsLP { get; set; }
        public bool IsLT { get; set; }
        public bool IsIDT { get; set; }
        public string IsICT { get; set; }
        public string CPLPNumber { get; set; }
        public string IDTICTNumber { get; set; }
        public string OrignalManufacture { get; set; }
        public string packaging { get; set; }
        public decimal? weight { get; set; }
        public string supplier { get; set; }
        public string Remarks { get; set; }
    }
    public class ViewStockOut
    {
        public int StockInId { get; set; }
        public int BatchId { get; set; }
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string CategoryName { get; set; }
        public string AccountingUnit { get; set; }
        public int Quantity { get; set; }
        public string StockType { get; set; }
        public string Remarks { get; set; }
        public string VoucherNumber { get; set; }
        public DateTime DateOfReceipt { get; set; }
        public DateTime DateofDispatch { get; set; }
        public String BatchName { get; set; }
        public bool IsIDT { get; set; }
        public bool IsICT { get; set; }
        public bool IsAWS { get; set; }
        public string IDTReferenceNumber { get; set; }
        public List<BatchDetails> Batch { get; set; }
    }
    public class AvailableStock
    {
        public int StockInId { get; set; }
        public string LotBatchId { get; set; }
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string CategoryName { get; set; }
        public string Description { get; set; }
        public DateTime DateOfReceipt { get; set; }
        public string unit { get; set; }
        public int TotalAvailableQuantity { get; set; }
        public string Sheds { get; set; }
        public List<BatchDetails> Batch { get; set; }

    }
    public class AvailableStockForDashboard
    {
        public int WarehouseId { get; set; }
        public string BatchId { get; set; }
        public List<AvailabeProductForDashboard> availabeProductForDashboards { get; set; }

    }
    public class AvailabeProductForDashboard
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string CategoryName { get; set; }
        public int Quantity { get; set; }
        public string Unit { get; set; }
        public bool AvailableInOther { get; set; }
        public string OtherShedList { get; set; }
        public bool IsAvailableinOther { get; set; }
        public string WarhouseList { get; set; }

        public List<BatchDetails> Batch { get; set; }
    }
}
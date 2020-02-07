using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
    public class Stock
    {
        // public int Id { get; set; }
        public int StockInId { get; set; }
        public string LotBatchId { get; set; }
        public int ProductId { get; set; }
        public DateTime DateOfReceipt { get; set; }
        public string CrvNumber { get; set; }
        public string Description { get; set; }
        public string ReceivedFrom { get; set; }
        public string PackingMaterialName { get; set; }
        public string OriginalManufacture { get; set; }
        public string GenericName { get; set; }
        public decimal Weight { get; set; }
        //public int AddedBy { get; set; }
        //public DateTime AddedOn { get; set; }
        //public int ModifiedBy { get; set; }
        //public DateTime ModifiedOn { get; set; }
        public Boolean IsActive { get; set; }

    }
    public class Batch
    {
        public int BatchId { get; set; }
        public string BatchName { get; set; }
        public int Quantity { get; set; }
        public int WarehouseSectionId { get; set; }
        public DateTime MfgDate { get; set; }
        public DateTime ExpDate { get; set; }
        public DateTime EslDate { get; set; }
        public int AvailableQuantity { get; set; }


    }

    public class ProductQuantity
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public int Quantity { get; set; }
    }
    public class StockIn
    {
        public List<Batch> Batch { get; set; }
        public Stock stock { get; set; }
    }
    public class StockOut
    {
        public int LotBatchId { get; set; }
        public int Quantity { get; set; }
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
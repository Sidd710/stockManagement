using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
        public class BatchDetails
        {
            public int BID { get; set; }
            public string BatchName { get; set; }
            public string BatchCode { get; set; }
            public string BatchDesc { get; set; }
            public string BatchNo { get; set; }
            public string ATNo { get; set; }
            public string VechicleNo { get; set; }
            public string RecievedFrom { get; set; }
            public int PID { get; set; }
            public DateTime MFGDate { get; set; }
            public DateTime EXPDate { get; set; }
            public bool IsActive { get; set; }

            public bool IsDeleted { get; set; }
            public int DepotID { get; set; }
            public int Quantity { get; set; }
            public DateTime Esl { get; set; }
            public bool IsSentto { get; set; }
            public string IsBatchStatus { get; set; }
            public int StockId { get; set; }
            public string ContactNo { get; set; }
            public string Remarks { get; set; }
            public decimal Cost { get; set; }
            public decimal CostOfParticular { get; set; }
            public decimal Weight { get; set; }
            public decimal WeightofParticular { get; set; }
            public string WeightUnit { get; set; }
            public string WarehouseNo { get; set; }
            public decimal SampleSentQty { get; set; }
            public int WarehouseID { get; set; }
            public int SectionID { get; set; }
            public int SectionRows { get; set; }
            public int SectionCol { get; set; }
            public int AvailableQuantity { get; set; }
        }

        public class BatchMasterList
        {
            public List<BatchDetails> BatchDetails { get; set; }
        }
    
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
    public class CPLTDetails
    {
        public int Id { get; set; }
        public int CPLTId { get; set; }
        public int ProdId { get; set; }
        public int OemId { get; set; }
        public int Quantity { get; set; }
        public int Rate { get; set; }
        public int Value { get; set; }
        public string DeliveryDate { get; set; }
        public bool Status { get; set; }
    }

    public class CPLTMaster
    {
        public int Id { get; set; }
        public string Type { get; set; }
        public string ReferenceNumber { get; set; }
        public int SupplierId { get; set; }
        public string TenderDate { get; set; }
        public string LD { get; set; }
    }
    public class CpLt
    {
        public CPLTMaster cpLTMaster { get; set; }
        public List<CPLTDetails> cpLTDetails { get; set; }
    }
}
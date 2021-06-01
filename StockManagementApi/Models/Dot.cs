using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
    public class DotModel
    {
        public int Id { get; set; }
        public string Dot { get; set; }
        public string AccountingUnit { get; set; }

        public string DotName { get; set; }
        public string GSReserve { get; set; }
        public bool IsActive { get; set; }
        public List<DotProductMaster> ProductListNew { get; set; }

    }
    public class DotProductMaster
    {
        public int DotProductId { get; set; }
        public int DotId { get; set; }
        public int? ProductId { get; set; }
        public string productName { get; set; }
    }
}
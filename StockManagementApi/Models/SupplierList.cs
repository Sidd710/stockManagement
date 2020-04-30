using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
    public class SupplierList
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public bool IsActivated { get; set; }
        public int ContactNo { get; set; }
    }
    public class Supplier
    {
        public List<SupplierList> SupplierList { get; set; }
    }
}
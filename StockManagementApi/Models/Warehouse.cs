using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
    public class Warehouse
    {
        public int ID {get;set;}
        public string WareHouseNo { get; set; }
        public string Description { get; set; }
        public int AddedBy { get; set; }
        public DateTime Addedon { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime ModifiedOn { get; set; }
        public Boolean IsActive { get; set; }

    }
    public class WarehouseSection
    {
        public int ID { get; set; }
        public int WarehouseID { get; set; }
        public string Section { get; set; }
        public string SubSection { get; set; }
        public string Row { get; set; }
        public string Col { get; set; }
        public string Drawers { get; set; }
        public int AddedBy { get; set; }
        public DateTime Addedon { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime ModifiedOn { get; set; }

    }

    public class WareHouseList
    {
        public int WarehouseId { get; set; }
        public string WareHouseNo { get;set;}
        public string WarehouseSection { get; set; }
        public int SectionId { get; set; }
    }
    public class WareHouseData
    {
        public List<Warehouse> WareHouseLists { get; set; }

    }
        

}
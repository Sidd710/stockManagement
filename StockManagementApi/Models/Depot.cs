using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
    public class DepotList
    {
        public int Depu_Id { get; set; }
        public string Depu_Name { get; set; }
        public string Depu_Location { get; set; }
        public string Depot_Code { get; set; }
        public Boolean IsParent { get; set; }        
        public Boolean IsActive { get; set; }
        public int FormationId{ get; set; }
        public string Corp { get; set; }
        public string DepotNo { get; set; }
        public string IDT { get; set; }
        public string ICT { get; set; }
        public string AWS { get; set; }
        public string UnitName { get; set; }
        public int AddedBy { get; set; }
        public DateTime Addedon { get; set; }
        public int    ModifiedBy { get; set; }
        public DateTime ModifiedOn { get; set; }
        public int CommandId { get; set; }

    }
    public class Depot
    {
        public List<DepotList> DepotList { get; set; }
    }
}
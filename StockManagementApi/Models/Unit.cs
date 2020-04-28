using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
    public class UnitList
    {
        public int Unit_Id { get; set; }
        public int Depu_Id { get; set; }
        public string Unit_Name { get; set; }
        public string Unit_Code { get; set; }
        public string Unit_Desc { get; set; }
        public Boolean IsActive { get; set; }
        public int Command { get; set; }
        public int Formation { get; set; }
        public int UnitType { get; set; }
        public int AddedBy { get; set; }
        public DateTime Addedon { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime ModifiedOn { get; set; }
        

    }
    public class Unit
    {
        public List<UnitList> UnitList { get; set; }
    }
}
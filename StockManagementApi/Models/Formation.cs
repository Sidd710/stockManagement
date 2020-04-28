using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
    public class FormationList
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Descripition { get; set; }
        public Boolean IsActive { get; set; }
        public int AddedBy { get; set; }
        public DateTime Addedon { get; set; }
        public int UpdatedBy { get; set; }
        public DateTime UndatedOn { get; set; }
        public int CommandId { get; set; }
   
    }
    public class Formation
    {
        public List<FormationList> FormationList { get; set; }
    }
}
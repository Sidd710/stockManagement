using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
    public class CommandList
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Descripition { get; set; }
        public Boolean IsActive { get; set; }
        public int AddedBy { get; set; }
        public DateTime AddedOn { get; set; }
        public int UpdatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
   
    }
    public class Command
    {
        public List<CommandList> CommandList { get; set; }
    }
}
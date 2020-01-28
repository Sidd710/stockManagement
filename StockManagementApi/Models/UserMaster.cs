using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
    public class UserMaster
    {
        public int User_Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string User_name { get; set; }
        public int RoleId { get; set; }
        public string Address { get; set; }
        public string ContactNo { get; set; }
        public string ArmyNo { get; set; }
        public string Password { get; set; }
        public bool IsActive { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int AddedBy { get; set; }
        public int City { get; set; }
        public int Country { get; set; }
        public int State { get; set; }
        public string UserCode { get; set; }
    }
    public class RoleMaster
    {
        public int Role_ID { get; set; }
        public string Role_Code { get; set; }
        public string Role { get; set; }
        public string Role_Desc { get; set; }
        
    }
}
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace StockManagementApi.Models
{
    public class CategoryType
    {
        public int ID { get; set; }
        [Required]
        public string Type { get; set; }
        [Required]
        public string Description { get; set; }
        public int Category_ID { get; set; }
        public bool IsActive { get; set; }
        public DateTime AddedOn { get; set; }
        public string AddedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
        public int ModifiedBy { get; set; }
    }
    public class Category           
    {
        public int ID { get; set; }

        public string Category_Code { get; set; }
        public string Category_Name { get; set; }

        public string Category_desc { get; set; }

        public bool IsActive { get; set; }
        public DateTime AddedOn { get; set; }
        public string AddedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
        public int ModifiedBy { get; set; }
    }
    public class CategoryListData
    {
        public dynamic CategoryList { get; set; }
    }
}
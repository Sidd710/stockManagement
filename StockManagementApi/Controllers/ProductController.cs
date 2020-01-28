using Dapper;
using StockManagementApi.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;

namespace StockManagementApi.Controllers
{
    public class ProductController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        [HttpPost]
        [ResponseType(typeof(Product))]
        [Authorize(Roles = "17")]
        public async Task<IHttpActionResult> AddProduct([FromBody]Product value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();
                var identity = (ClaimsIdentity)User.Identity;
                var userId = identity.Claims.Where(c => c.Type == ClaimTypes.Sid)
                   .Select(c => c.Value).SingleOrDefault();
                var userExist = connection.Query<Product>("Select * from ProductMaster where Category_Id = @Category_Id and Product_Name =@Product_Name", new { Category_Id = value.Category_Id, Product_Name=value.Product_Name }).FirstOrDefault();
                if (userExist == null)
                {
                    var p = new Product { Product_Name = value.Product_Name, Product_Desc = value.Product_Desc, Short_Product_Desc = value.Short_Product_Desc, Admin_Remarks = value.Admin_Remarks, product_cost = value.product_cost, Product_Code = value.Product_Code, IsActive = value.IsActive, Category_Id = value.Category_Id, AddedOn = DateTime.Now,
                        AddedBy = userId, StockQty = value.StockQty, Cat = value.Cat, GSreservre = value.GSreservre, productUnit = value.productUnit,IsProductStatus="Pending"};
                    p.Product_ID = connection.Query<int>(@"insert ProductMaster(Product_Name,Product_Desc,Short_Product_Desc,Admin_Remarks,product_cost,Product_Code,IsActive,Category_Id,
                        AddedOn,AddedBy,StockQty,Cat,GSreservre,productUnit,IsProductStatus) values (@Product_Name,@Product_Desc,@Short_Product_Desc,@Admin_Remarks,@product_cost,@Product_Code,@IsActive,@Category_Id,
                        @AddedOn,@AddedBy,@StockQty,@Cat,@GSreservre,@productUnit,@IsProductStatus) select cast(scope_identity() as int)", p).First();
                    
                    return Json(new { Message = "Record Inserted Successfully" });


                }
                else
                {
                    throw new ProcessException("Username already exists");
                }


            }
        }
        public class ProcessException : Exception
        {
            public ProcessException(string message)
                : base(message)
            {

            }
        }
    }
}

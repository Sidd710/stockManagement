using Dapper;
using Newtonsoft.Json;
using StockManagementApi.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
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
        
        public async Task<IHttpActionResult> AddProduct([FromBody]List<ProductListNew> value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();
                for (int i = 0; i < value.Count; i++)
                {
                    var p = new ProductListNew
                    {
                        VarietyName = value[i].VarietyName,
                        CatTypeId = value[i].CatTypeId,
                        Unit = value[i].Unit,
                        IsLot = value[i].IsLot,
                        IsActive = true,
                        GName = value[i].GName,
                        AddedOn = DateTime.Now,
                        AddedBy = 1,
                        speci = value[i].speci,
                        GSreservre = value[i].GSreservre,
                        AdminComment = value[i].AdminComment,
                        ProductDesc = value[i].ProductDesc,
                    };
                    p.Id = connection.Query<int>(@"insert ProductMaster_New(VarietyName,CatTypeId,Unit,IsLot,IsActive,GName,AddedOn,
                        AddedBy,speci,GSreservre,AdminComment,ProductDesc) values (@VarietyName,@CatTypeId,@Unit,@IsLot,@IsActive,@GName,@AddedOn,
                        @AddedBy,@speci,@GSreservre,@AdminComment,@ProductDesc) select cast(scope_identity() as int)", p).First();

                }
                //var userExist = connection.Query<Product>("Select * from ProductMaster where Category_Id = @Category_Id and Product_Name =@Product_Name", new { Category_Id = value.Category_Id, Product_Name=value.Product_Name }).FirstOrDefault();
                //if (userExist == null)
                //{

                return Json(new { Message = "Record Inserted Successfully" });


                //}
                //else
                //{
                //    throw new ProcessException("Username already exists");
                //}


            }
        }
        public dynamic GetAllProduct()
        {
            // var identity = (ClaimsIdentity)User.Identity;
            var connection = new SqlConnection(sqlConnectionString);
            SqlCommand command = new SqlCommand("spManageProductNew", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            connection.Open();

            DataTable dt = new DataTable();

            dt.Load(command.ExecuteReader());
            var list = DataTableToJSONWithJSONNet(dt);
            dynamic json = JsonConvert.DeserializeObject(list);


            return json;

        }

        public string DataTableToJSONWithJSONNet(DataTable table)
        {
            string JSONString = string.Empty;
            JSONString = JsonConvert.SerializeObject(table);
            return JSONString;
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

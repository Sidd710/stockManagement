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
using System.Threading.Tasks;
using System.Transactions;
using System.Web.Http;
using static StockManagementApi.Controllers.CategoryController;

namespace StockManagementApi.Controllers
{
    public class SupplierController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        [HttpPost]
        public async Task<IHttpActionResult> AddSupplier([FromBody]SupplierList value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CommandExist = connection.Query<SupplierList>("Select * from Supplier where Name = @Name", new { Name = value.Name }).FirstOrDefault();
                if (CommandExist == null)
                {
                    var p = new SupplierList
                    {
                        Name = value.Name,
                        Address = value.Address,
                        ContactNo =  value.ContactNo,
                        IsActivated = value.IsActivated
                    
                    };
                    p.Id = connection.Query<int>(@"insert Supplier(Name,Address,ContactNo,IsActivated) values (@Name,@Address,@ContactNo,@IsActivated) select cast(scope_identity() as int)", p).First();

                    return Json(new { Message = "Record Inserted Successfully" });


                }
                else
                {
                    throw new ProcessException("Formation already exists");
                }


            }
        }

        [HttpPut]
        public async Task<IHttpActionResult> DeleteSupplier([FromBody]Object Id)
        {
            var categoryId = Convert.ToInt32(Id);
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CategoryExist = connection.Query<FormationList>("Select * from Supplier where Id = @Id", new { Id = categoryId }).FirstOrDefault();
                if (CategoryExist == null)
                {
                    throw new ProcessException("Selected supplier not exists");
                }
                else
                {
                    string updateQuery = @"UPDATE Supplier Set IsActivated = @IsActive where Id = @Id";
                    var result = connection.Execute(updateQuery, new { IsActive = false, Id = categoryId });

                    return Json(new { Message = "Record deleted successfully!" });
                }


            }
        }
        public dynamic GetAllSupplier()
        {
            var connection = new SqlConnection(sqlConnectionString);
            SqlCommand command = new SqlCommand("spManageSupplier", connection);
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

        public dynamic GetBySupplierId(int Id)
        {
            var supplier = new SupplierList();
            var connection = new SqlConnection(sqlConnectionString);
            supplier = connection.Query<SupplierList>("Select * from Supplier where Id = @Id", new { Id = Id }).FirstOrDefault();
            return supplier;
        }

        [HttpPost]
        public async Task<IHttpActionResult> UpdateOriginalManufacturer([FromBody]SupplierList value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var supplier = new SupplierList()
                {
                    Address = value.Address,
                    ContactNo = value.ContactNo,
                    IsActivated = value.IsActivated,
                    Name = value.Name,
                    Id = value.Id
                };

                string updateQuery = @"UPDATE Supplier SET Address = @Address,ContactNo=@ContactNo,IsActivated = @IsActivated, Name= @Name WHERE Id = @Id";

                var result = connection.Execute(updateQuery, supplier);
                scope.Complete();
                return Json(new { Message = "Record Updated Successfully" });
            }
        }
    }
}

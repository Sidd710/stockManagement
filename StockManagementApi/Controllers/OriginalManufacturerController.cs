using Dapper;
using Newtonsoft.Json;
using StockManagementApi.Models;
using System;
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
    public class OriginalManufacturerController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        [HttpPost]
        public async Task<IHttpActionResult> AddOriginalManufacturer([FromBody]OriginalManufacturerList value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CommandExist = connection.Query<OriginalManufacturerList>("Select * from Supplier where Name = @Name", new { Name = value.Name }).FirstOrDefault();
                if (CommandExist == null)
                {
                    var p = new SupplierList
                    {
                        Name = value.Name,
                        Address = value.Address,
                        ContactNo = value.ContactNo,
                        IsActivated = value.IsActivated

                    };
                    p.Id = connection.Query<int>(@"insert OriginalManufacture(Name,Address,ContactNo,IsActivated) values (@Name,@Address,@ContactNo,@IsActivated) select cast(scope_identity() as int)", p).First();

                    return Json(new { Message = "Record Inserted Successfully" });


                }
                else
                {
                    throw new ProcessException("Formation already exists");
                }


            }
        }
        public dynamic GetAllOriginalManufacturer()
        {
            var connection = new SqlConnection(sqlConnectionString);
            SqlCommand command = new SqlCommand("spManageOriginalManufacture", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            connection.Open();

            DataTable dt = new DataTable();

            dt.Load(command.ExecuteReader());
            var list = DataTableToJSONWithJSONNet(dt);
            dynamic json = JsonConvert.DeserializeObject(list);


            return json;

        }


        [HttpPut]
        public async Task<IHttpActionResult> DeleteOriginalManufacturer([FromBody]Object Id)
        {
            var categoryId = Convert.ToInt32(Id);
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CategoryExist = connection.Query<FormationList>("Select * from OriginalManufacture where Id = @Id", new { Id = categoryId }).FirstOrDefault();
                if (CategoryExist == null)
                {
                    throw new ProcessException("Selected original manufacturer not exists");
                }
                else
                {
                    string updateQuery = @"UPDATE OriginalManufacture Set IsActivated = @IsActive where Id = @Id";
                    var result = connection.Execute(updateQuery, new { IsActive = false, Id = categoryId });

                    return Json(new { Message = "Record deleted successfully!" });
                }


            }
        }

        private string DataTableToJSONWithJSONNet(DataTable table)
        {
            string JSONString = string.Empty;
            JSONString = JsonConvert.SerializeObject(table);
            return JSONString;
        }

        public dynamic GetByOriginalManufacturerId(int Id)
        {
            var orgManufacturer = new OriginalManufacturerList();
            var connection = new SqlConnection(sqlConnectionString);
            orgManufacturer = connection.Query<OriginalManufacturerList>("Select * from OriginalManufacture where Id = @Id", new { Id = Id }).FirstOrDefault();
            return orgManufacturer;
        }

        [HttpPost]
        public async Task<IHttpActionResult> UpdateOriginalManufacturer([FromBody]OriginalManufacturerList value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var orgManufacturer = new OriginalManufacturerList()
                {
                    Address = value.Address,
                    ContactNo = value.ContactNo,
                    IsActivated = value.IsActivated,
                    Name = value.Name,
                    Id = value.Id
                };

                string updateQuery = @"UPDATE OriginalManufacture SET Address = @Address,ContactNo=@ContactNo,IsActivated = @IsActivated, Name= @Name WHERE Id = @Id";

                var result = connection.Execute(updateQuery, orgManufacturer);
                scope.Complete();
                return Json(new { Message = "Record Updated Successfully" });
            }
        }
    }
}

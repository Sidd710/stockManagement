using Dapper;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
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
    public class FormationController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        [HttpPost]
        public async Task<IHttpActionResult> AddFormation([FromBody]FormationList value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CommandExist = connection.Query<FormationList>("Select * from Formation where Name = @Name", new { Name = value.Name }).FirstOrDefault();
                if (CommandExist == null)
                {
                    var p = new FormationList
                    {
                        Name = value.Name,
                        Descripition = value.Descripition,
                        CommandId= value.CommandId,
                        IsActive = true,
                        Addedon = DateTime.Now,
                        UndatedOn = DateTime.Now

                    };
                    p.Id = connection.Query<int>(@"insert Formation(Name,Descripition,CommandId,IsActive,Addedon,UndatedOn) values (@Name,@Descripition,@CommandId,@IsActive,@Addedon,@UndatedOn) select cast(scope_identity() as int)", p).First();

                    return Json(new { Message = "Record Inserted Successfully" });


                }
                else
                {
                    throw new ProcessException("Formation already exists");
                }


            }
        }
        public dynamic GetAllFormation()
        {
            // var identity = (ClaimsIdentity)User.Identity;
            Formation formation = new Formation();
            //formation.FormationList = new List<FormationList>();

            //using (var connection = new SqlConnection(sqlConnectionString))
            //{
            //    connection.Open();
            //    formation.FormationList = connection.Query<FormationList>("Select * from Formation where IsActive =1").ToList();
            //    connection.Close();
            //}
            //return formation;
            var connection = new SqlConnection(sqlConnectionString);
           SqlCommand command = new SqlCommand("spManageFormation", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            connection.Open();

            DataTable dt = new DataTable();

            dt.Load(command.ExecuteReader());
            var list = DataTableToJSONWithJSONNet(dt);
            dynamic json = JsonConvert.DeserializeObject(list);


            return json;

        }

        [HttpPut]
        public async Task<IHttpActionResult> DeleteFormation([FromBody]Object Id)
        {
            var commandId = Convert.ToInt32(Id);
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CommandExist = connection.Query<FormationList>("Select * from Formation where Id = @Id", new { Id = commandId }).FirstOrDefault();
                if (CommandExist == null)
                {
                    throw new ProcessException("Selected formation not exists");
                }
                else
                {
                    string updateQuery = @"UPDATE Formation Set IsActive = @IsActive where Id = @Id";
                    var result = connection.Execute(updateQuery, new { IsActive = false, Id = commandId });

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

        public dynamic GetByFormationId(int Id)
        {
            var formation = new FormationList();
            var connection = new SqlConnection(sqlConnectionString);
            formation = connection.Query<FormationList>("Select * from Formation where Id = @Id", new { Id = Id }).FirstOrDefault();
            return formation;
        }

        [HttpPost]
        public async Task<IHttpActionResult> UpdateFormation([FromBody]FormationList value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var Name = value.Name;
                var Descripition = value.Descripition;
                var UndatedOn = DateTime.Now;
                var CommandId = value.CommandId;
                var Id = value.Id;
                

                string updateQuery = @"UPDATE Formation SET Name = @Name,Descripition=@Descripition,UndatedOn=@UndatedOn,CommandId=@CommandId WHERE Id = @Id";

                var result = connection.Execute(updateQuery, new
                {
                    Name,
                    Descripition,
                    UndatedOn,
                    CommandId,
                    Id
                });
                scope.Complete();
                return Json(new { Message = "Record Updated Successfully" });
            }
        }

    }
}

using Dapper;
using StockManagementApi.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using static StockManagementApi.Controllers.CategoryController;

namespace StockManagementApi.Controllers
{
    public class CommandController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        [HttpPost]
        public async Task<IHttpActionResult> AddCommand([FromBody]CommandList value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CommandExist = connection.Query<CommandList>("Select * from CommandMaster where Name = @Name", new { Name = value.Name }).FirstOrDefault();
                if (CommandExist == null)
                {
                    var p = new CommandList
                    {
                        Name = value.Name,
                        Descripition = value.Descripition,
                        IsActive = true,
                        AddedOn = DateTime.Now,
                        UndatedOn = DateTime.Now

                    };
                    p.Id = connection.Query<int>(@"insert CommandMaster(Name,Descripition,IsActive,AddedOn,UndatedOn) values (@Name,@Descripition,@IsActive,@AddedOn,@UndatedOn) select cast(scope_identity() as int)", p).First();

                    return Json(new { Message = "Record Inserted Successfully" });


                }
                else
                {
                    throw new ProcessException("Username already exists");
                }


            }
        }
        public Command GetAllCommand()
        {
            // var identity = (ClaimsIdentity)User.Identity;
            Command command = new Command();
            command.CommandList = new List<CommandList>();

            using (var connection = new SqlConnection(sqlConnectionString))
            {
                connection.Open();
                command.CommandList = connection.Query<CommandList>("Select * from CommandMaster where IsActive =1").ToList();
                connection.Close();
            }
            return command;
        }

        [HttpPut]
        public async Task<IHttpActionResult> DeleteCommand([FromBody]Object Id)
        {
            var commandId = Convert.ToInt32(Id);
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CommandExist = connection.Query<CommandList>("Select * from CommandMaster where Id = @Id", new { Id = commandId }).FirstOrDefault();
                if (CommandExist == null)
                {
                    throw new ProcessException("Selected command not exists");
                }
                else
                {                     
                    string updateQuery = @"UPDATE CommandMaster Set IsActive = @IsActive where Id = @Id";
                    var result = connection.Execute(updateQuery, new { IsActive = false, Id = commandId });
                   
                    return Json(new { Message = "Record deleted successfully!" });
                }


            }
        }
    }
}

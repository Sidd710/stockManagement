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
               
                var CommandExist = connection.Query<CommandList>("Select * from CommandMaster where Name = @Name" , new { Name = value.Name}).FirstOrDefault();
                if (CommandExist == null)
                {
                    var p = new CommandList
                    {
                        Name = value.Name,
                        Descripition = value.Descripition,
                        IsActive = true,
                        AddedOn=DateTime.Now,
                        UndatedOn= DateTime.Now
                        
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
    }
}

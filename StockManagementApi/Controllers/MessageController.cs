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

namespace StockManagementApi.Controllers
{
    public class MessageController : ApiController

    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        [HttpPost]
        public async Task<IHttpActionResult> AddMesage([FromBody]MessageName message)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            using (var connection = new SqlConnection(sqlConnectionString))
            {
                connection.Open();

                var p = new MessageName { Message = message.Message};
                p.MessageId = connection.Query<int>(@"insert tbl_message(Message) values (@Message) select cast(scope_identity() as int)", p).First();

                return Json(new { Message = "Record Inserted Successfully" });
            }


        }
    }
}

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
using System.Web.Http;

namespace StockManagementApi.Controllers
{
    public class IDTICTController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        [HttpPost]
        public async Task<IHttpActionResult> AddIdtIctIn([FromBody]IdtIctInModel value)
        {
            return Ok();
        }
    }
}

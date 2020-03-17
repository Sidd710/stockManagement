using Dapper;
using StockManagementApi.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;


namespace StockManagementApi.Controllers
{
    public class BatchController : ApiController
    {
        public BatchMasterList GetAllBatch()
        {
            // var identity = (ClaimsIdentity)User.Identity;
            BatchMasterList batch = new BatchMasterList();
            batch.BatchDetails = new List<BatchDetails>();
            string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
            using (var connection = new SqlConnection(sqlConnectionString))
            {
                connection.Open();
                batch.BatchDetails = connection.Query<BatchDetails>("Select * from BatchMaster").ToList();
                connection.Close();
            }
            return batch;
        }
    }
}

﻿using Dapper;
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

namespace StockManagementApi.Controllers
{
    public class IDTICTController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        [HttpPost]
        public async Task<IHttpActionResult> AddIdtIctIn([FromBody]IdtIctInModel value)
        {
            using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {
                try
                {
                    var p = new firstForm
                    {
                        IdtIctType   = value.firstForm.IdtIctType,
                        ReferenceNumber = value.firstForm.ReferenceNumber,
                        DateOfEntry = value.firstForm.DateOfEntry,
                       

                    };
                    p.Id = connection.Query<int>(@"insert IdtIcTMaster(IdtIctType,ReferenceNumber,DateOfEntry) values (@IdtIctType,@ReferenceNumber,@DateOfEntry) select cast(scope_identity() as int)", p).First();
                    foreach (var item in value.depotProdcutValueList)
                    {
                        var data = new depotProductValueModel
                        {
                            productId = item.productId,
                            depotId = item.depotId,
                            quantity = item.quantity,
                            date = item.date,
                             IdtIctMasterId=p.Id

                        };
                        var id = connection.Query<int>(@"insert IdtIctDetails(IdtIctMasterId,productId,depotId,quantity,date) values (@IdtIctMasterId,@productId,@depotId,@quantity,@date) select cast(scope_identity() as int)", data).First();
                    }
                    scope.Complete();
                    return Json(new { Message = "Record Inserted Successfully" });
                }
                catch (Exception e)
                {
                    // Not needed any rollback, if you don't call Complete
                    // a rollback is automatic exiting from the using block
                    connection.BeginTransaction().Rollback();
                    return Json(new { Message = "Error" });

                }
            }
        }
        [HttpGet]
        public dynamic ViewIdt()
        {
            CPLTMaster cpLtdata = new CPLTMaster();
            var connection = new SqlConnection(sqlConnectionString);
            SqlCommand command = new SqlCommand("spManageIdtIct", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            connection.Open();

            DataTable dt = new DataTable();

            dt.Load(command.ExecuteReader());
            var list = DataTableToJSONWithJSONNet(dt);
            dynamic json = JsonConvert.DeserializeObject(list);

            //  cpLtdata = json;
            return json;

        }
        public dynamic GetByIdt(int Id)
        {
            IdtDetails idtData = new IdtDetails();
            var connection = new SqlConnection(sqlConnectionString);
            idtData.IdtIcTMaster = connection.Query<firstForm>("Select * from IdtIcTMaster where Id = @Id", new { Id = Id }).FirstOrDefault();
            var IdtIctMasterId = Id;
            idtData.IdtIctDetails = connection.Query<depotProductValueModel>("Select * from IdtIctDetails where IdtIctMasterId = @IdtIctMasterId", new { IdtIctMasterId = IdtIctMasterId }).ToList();
            return idtData;
        }
        private string DataTableToJSONWithJSONNet(DataTable table)
        {
            string JSONString = string.Empty;
            JSONString = JsonConvert.SerializeObject(table);
            return JSONString;
        }
    }
    
}

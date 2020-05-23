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

namespace StockManagementApi.Controllers
{
    public class CPLTController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        [HttpPost]
        public async Task<IHttpActionResult> AddCP([FromBody]CpLt value)
        {
            using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {
                try
                {
                    var p = new CPLTMaster
                    {
                        LD = value.cpLTMaster.LD,
                        ReferenceNumber = value.cpLTMaster.ReferenceNumber,
                        SupplierId = value.cpLTMaster.SupplierId,
                        TenderDate = value.cpLTMaster.TenderDate,
                        Type=value.cpLTMaster.Type
                        
                    };
                    p.Id = connection.Query<int>(@"insert CPLTMaster(LD,ReferenceNumber,SupplierId,TenderDate,Type) values (@LD,@ReferenceNumber,@SupplierId,@TenderDate,@Type) select cast(scope_identity() as int)", p).First();
                    foreach (var item in value.cpLTDetails)
                    {
                        var data = new CPLTDetails
                        {
                            DeliveryDate = item.DeliveryDate,
                           OemId  = item.OemId,
                            ProdId = item.ProdId,
                            Quantity = item.Quantity,
                            Rate = item.Rate,
                            Value=item.Value,
                            CPLTId=p.Id

                        };
                        data.Id = connection.Query<int>(@"insert CPLTDetails(DeliveryDate,OemId,ProdId,Quantity,Rate,Value,CPLTId) values (@DeliveryDate,@OemId,@ProdId,@Quantity,@Rate,@Value,@CPLTId) select cast(scope_identity() as int)", data).First();
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
        public  dynamic ViewCP()
        {
            CPLTMaster cpLtdata = new CPLTMaster();
            var connection = new SqlConnection(sqlConnectionString);
            SqlCommand command = new SqlCommand("spManageCPLT", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            connection.Open();

            DataTable dt = new DataTable();

            dt.Load(command.ExecuteReader());
            var list = DataTableToJSONWithJSONNet(dt);
            dynamic json = JsonConvert.DeserializeObject(list);

          //  cpLtdata = json;
            return json;
           
        }

        private string DataTableToJSONWithJSONNet(DataTable table)
        {
            string JSONString = string.Empty;
            JSONString = JsonConvert.SerializeObject(table);
            return JSONString;
        }
    }
}

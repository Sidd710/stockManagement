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
                    connection.Open();
                    var p = new CPLTMaster
                    {
                        LD = value.cpLTMaster.LD,
                        ReferenceNumber = value.cpLTMaster.ReferenceNumber,
                        SupplierId = value.cpLTMaster.SupplierId,
                        TenderDate = value.cpLTMaster.TenderDate,
                        Type = value.cpLTMaster.Type

                    };
                    p.Id = connection.Query<int>(@"insert CPLTMaster(LD,ReferenceNumber,SupplierId,TenderDate,Type) values (@LD,@ReferenceNumber,@SupplierId,@TenderDate,@Type) select cast(scope_identity() as int)", p).First();
                    foreach (var item in value.cpLTDetails)
                    {
                        var data = new CPLTDetails
                        {
                            DeliveryDate = item.DeliveryDate,
                            OemId = item.OemId,
                            ProdId = item.ProdId,
                            Quantity = item.Quantity,
                            Rate = item.Rate,
                            Value = item.Value,
                            CPLTId = p.Id,
                            Status = true,
                            AvailableQuantity=item.Quantity,
                            Addedon=DateTime.Now,
                            
                        };
                        data.Id = connection.Query<int>(@"insert CPLTDetails(DeliveryDate,OemId,ProdId,Quantity,Rate,Value,CPLTId,Status,AvailableQuantity,Addedon) values (@DeliveryDate,@OemId,@ProdId,@Quantity,@Rate,@Value,@CPLTId,@Status,@AvailableQuantity,@Addedon) select cast(scope_identity() as int)", data).First();
                    }
                    scope.Complete();
                    return Json(new { Message = "Record Inserted Successfully" });
                }
                catch (Exception ex)
                {
                    // Not needed any rollback, if you don't call Complete
                    // a rollback is automatic exiting from the using block
                    connection.BeginTransaction().Rollback();
                    return Json(new { Message = "Error" });

                }
            }

        }
        [HttpGet]
        public dynamic ViewCP()
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

        public dynamic GetByCP(int Id)
        {
            CpLt cpLT = new CpLt();
            var connection = new SqlConnection(sqlConnectionString);
            cpLT.cpLTMaster = connection.Query<CPLTMaster>("Select * from CPLTMaster where Id = @Id", new { Id = Id }).FirstOrDefault();
            var tenderDates = Convert.ToDateTime(cpLT.cpLTMaster.TenderDate).Date;
            string tenderDate = tenderDates.ToString("yyyy-MM-dd");
            cpLT.cpLTMaster.TenderDate = tenderDate;
            var CPLTId = Id;
            cpLT.cpLTDetails = connection.Query<CPLTDetails>("Select * from CPLTDetails where CPLTId = @CPLTId and Status = @Status", new { CPLTId = CPLTId, Status = true }).ToList();
            for (int i = 0; i < cpLT.cpLTDetails.Count; i++)
            {
                var datetime = Convert.ToDateTime(cpLT.cpLTDetails[i].DeliveryDate).Date; //only
                string date = datetime.ToString("yyyy-MM-dd");
                cpLT.cpLTDetails[i].DeliveryDate = date;
            }
            return cpLT;
        }
        [HttpPost]
        public async Task<IHttpActionResult> EditCP([FromBody]CpLt value)
        {
            using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {
                try
                {
                    var Id = Convert.ToInt32(value.cpLTMaster.Id);
                    connection.Open();

                    var CpLTExist = connection.Query<int>("Select * from CPLTMaster where ID = @Id", new { Id = Id }).FirstOrDefault();
                    if (CpLTExist == null)
                    {
                        throw new ProcessException("Selected CPLT not exists");
                    }
                    else
                    {
                        var Type = value.cpLTMaster.Type;
                        var ReferenceNumber = value.cpLTMaster.ReferenceNumber;
                        var SupplierId = value.cpLTMaster.SupplierId;
                        var TenderDate = value.cpLTMaster.TenderDate;
                        var LD = value.cpLTMaster.LD;


                        //};
                        // string updateQuery = @"UPDATE IdtIcTMaster SET IdtIctType=@IdtIctType,ReferenceNumber=@ReferenceNumber,DateOfEntry=@DateOfEntry,Status=@Status where  Id = @Id";
                        string updateQuery = @"UPDATE CPLTMaster SET Type = @Type,ReferenceNumber=@ReferenceNumber,SupplierId=@SupplierId,TenderDate=@TenderDate,LD=@LD WHERE Id = @Id";

                        var result = connection.Execute(updateQuery, new
                        {
                            Type,
                            ReferenceNumber,
                            SupplierId,
                            TenderDate,
                            LD,
                            Id
                        });
                        var listOfIds = new List<int>();
                        for (int i = 0; i < value.cpLTDetails.Count; i++)
                        {
                            if (value.cpLTDetails[i].CPLTId != 0)
                            {
                                listOfIds.Add(value.cpLTDetails[i].CPLTId);
                                //var currentRecord = connection.Query<int>("Select * from CPLTDetails where ID = @Id and Status = @Status", new { Id = value.cpLTDetails[i].Id, Status = true }).FirstOrDefault();
                                ////  var isRecordExist
                                //string deleteQuery = @"UPDATE CPLTDetails Set Status = @IsActive where Id = @Id";
                                //var resultfordelte = connection.Execute(deleteQuery, new { IsActive = false, Id = value.cpLTDetails[i].Id });

                            }
                            else
                            {
                                var data = new CPLTDetails
                                {
                                    Id = value.cpLTDetails[i].Id,
                                    CPLTId = value.cpLTDetails[i].CPLTId,
                                    ProdId = value.cpLTDetails[i].ProdId,
                                    OemId = value.cpLTDetails[i].OemId,
                                    Quantity = value.cpLTDetails[i].Quantity,
                                    Rate = value.cpLTDetails[i].Rate,
                                    Value = value.cpLTDetails[i].Value,
                                    DeliveryDate = value.cpLTDetails[i].DeliveryDate,
                                    Status = true
                                };
                                var id = connection.Query<int>(@"insert CPLTDetails(DeliveryDate,OemId,ProdId,Quantity,Rate,Value,CPLTId,Status) values (@DeliveryDate,@OemId,@ProdId,@Quantity,@Rate,@Value,@CPLTId,@Status) select cast(scope_identity() as int)", data).First();
                            }

                        }
                        var currentActiveRecords = connection.Query<int>("Select Id from CPLTDetails where Status = @Status", new { Status = true }).ToList();
                        foreach (var item in currentActiveRecords)
                        {
                            var a = listOfIds.IndexOf(item);
                            if (a == -1)
                            {
                                //var currentRecord = connection.Query<int>("Select * from CPLTDetails where ID = @Id", new { Id = item}).FirstOrDefault();

                                string deleteQuery = @"UPDATE CPLTDetails Set Status = @IsActive where Id = @Id";
                                var resultfordelte = connection.Execute(deleteQuery, new { IsActive = false, Id = item });

                            }
                        }
                        scope.Complete();
                        return Json(new { Message = "Record Inserted Successfully" });
                    }

                }
                catch (Exception)
                {

                    throw;
                }
                // return Ok();
            }
        }


        private string DataTableToJSONWithJSONNet(DataTable table)
        {
            string JSONString = string.Empty;
            JSONString = JsonConvert.SerializeObject(table);
            return JSONString;
        }
    }
}

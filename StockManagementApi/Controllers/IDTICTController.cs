using Dapper;
using Newtonsoft.Json;
using StockManagementApi.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Transactions;
using System.Web.Http;
using static StockManagementApi.Controllers.CategoryController;

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
                        IdtIctType = value.firstForm.IdtIctType,
                        ReferenceNumber = value.firstForm.ReferenceNumber,
                        DateOfEntry = value.firstForm.DateOfEntry,
                        Status = value.status,


                    };
                    p.Id = connection.Query<int>(@"insert IdtIcTMaster(IdtIctType,ReferenceNumber,DateOfEntry,Status) values (@IdtIctType,@ReferenceNumber,@DateOfEntry,@Status) select cast(scope_identity() as int)", p).First();
                    foreach (var item in value.depotProdcutValueList)
                    {
                        var data = new depotProductValueModel
                        {
                            productId = item.productId,
                            depotId = item.depotId,
                            quantity = item.quantity,
                            date = item.date,
                            IdtIctMasterId = p.Id,
                            AvailableQuantity = item.quantity,
                            AddedOn = DateTime.Now

                        };
                        var id = connection.Query<int>(@"insert IdtIctDetails(IdtIctMasterId,productId,depotId,quantity,date,AvailableQuantity,AddedOn) values (@IdtIctMasterId,@productId,@depotId,@quantity,@date,@AvailableQuantity,@AddedOn) select cast(scope_identity() as int)", data).First();
                    }
                    scope.Complete();
                    return Json(new { Message = "Record Inserted Successfully" });
                }
                catch (Exception)
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
            var dateofEntry = Convert.ToDateTime(idtData.IdtIcTMaster.DateOfEntry).Date;
            string entryDate = dateofEntry.ToString("yyyy-MM-dd");
            idtData.IdtIcTMaster.DateOfEntry = Convert.ToDateTime(entryDate);
            var IdtIctMasterId = Id;
            idtData.IdtIctDetails = connection.Query<depotProductValueModel>("Select * from IdtIctDetails where IdtIctMasterId = @IdtIctMasterId", new { IdtIctMasterId = IdtIctMasterId }).ToList();
            for (int i = 0; i < idtData.IdtIctDetails.Count; i++)
            {
                var datetime = Convert.ToDateTime(idtData.IdtIctDetails[i].date).Date; //only
                string date = datetime.ToString("yyyy-MM-dd");
                idtData.IdtIctDetails[i].date = date;
            }
            return idtData;
        }


        [HttpPost]
        public async Task<IHttpActionResult> AddIdtIctOut([FromBody]IdtIctOutModel value)
        {
            using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {
                try
                {
                    var p = new firstForm
                    {
                        IdtIctType = value.firstForm.IdtIctType,
                        ReferenceNumber = value.firstForm.ReferenceNumber,
                        DateOfEntry = value.firstForm.DateOfEntry,
                        Status = value.status,


                    };
                    p.Id = connection.Query<int>(@"insert IdtIcTOutMaster(IdtIctType,ReferenceNumber,DateOfEntry,Status) values (@IdtIctType,@ReferenceNumber,@DateOfEntry,@Status) select cast(scope_identity() as int)", p).First();
                    if (value.firstForm.IdtIctType == "LUT")
                    {
                        foreach (var item in value.unitProductValueList)
                        {
                            var data = new unitProductValueModel
                            {
                                productId = item.productId,
                                unitId = item.unitId,
                                quantity = item.quantity,
                                date = item.date,
                                IdtIctMasterId = p.Id,
                                depotId = 0
                            };
                            var id = connection.Query<int>(@"insert IdtIctOutDetails(IdtIctOutMasterId,productId,unitId,quantity,date,depotId) values (@IdtIctMasterId,@productId,@unitId,@quantity,@date,@depotId) select cast(scope_identity() as int)", data).First();
                        }
                    }
                    else
                    {
                        foreach (var item in value.depotProdcutValueList)
                        {
                            var data = new depotProductValueModel
                            {
                                productId = item.productId,
                                depotId = item.depotId,
                                quantity = item.quantity,
                                date = item.date,
                                IdtIctMasterId = p.Id

                            };
                            var id = connection.Query<int>(@"insert IdtIctOutDetails(IdtIctOutMasterId,productId,depotId,quantity,date) values (@IdtIctMasterId,@productId,@depotId,@quantity,@date) select cast(scope_identity() as int)", data).First();
                        }
                    }

                    scope.Complete();
                    return Json(new { Message = "Record Inserted Successfully" });
                }
                catch (Exception)
                {
                    // Not needed any rollback, if you don't call Complete
                    // a rollback is automatic exiting from the using block
                    connection.BeginTransaction().Rollback();
                    return Json(new { Message = "Error" });

                }
            }
        }

        [HttpGet]
        public dynamic ViewIdtOut()
        {
            CPLTMaster cpLtdata = new CPLTMaster();
            var connection = new SqlConnection(sqlConnectionString);
            SqlCommand command = new SqlCommand("spManageIdtIctOut", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            connection.Open();

            DataTable dt = new DataTable();

            dt.Load(command.ExecuteReader());
            var list = DataTableToJSONWithJSONNet(dt);
            dynamic json = JsonConvert.DeserializeObject(list);

            //  cpLtdata = json;
            return json;

        }
        public dynamic GetByIdtOut(int Id)
        {
            IdtDetails idtData = new IdtDetails();
            var connection = new SqlConnection(sqlConnectionString);
            idtData.IdtIcTMaster = connection.Query<firstForm>("Select * from IdtIcTOutMaster where Id = @Id", new { Id = Id }).FirstOrDefault();
            var IdtIctMasterId = Id;
            idtData.IdtIctDetails = connection.Query<depotProductValueModel>("Select * from IdtIctOutDetails where IdtIctOutMasterId = @IdtIctMasterId", new { IdtIctMasterId = IdtIctMasterId }).ToList();
            var dateofEntry = Convert.ToDateTime(idtData.IdtIcTMaster.DateOfEntry).Date;
            string entryDate = dateofEntry.ToString("yyyy-MM-dd");
            idtData.IdtIcTMaster.DateOfEntry = Convert.ToDateTime(entryDate);
            for (int i = 0; i < idtData.IdtIctDetails.Count; i++)
            {
                var datetime = Convert.ToDateTime(idtData.IdtIctDetails[i].date).Date; //only
                string date = datetime.ToString("yyyy-MM-dd");
                idtData.IdtIctDetails[i].date = date;
            }
            return idtData;
        }

        public async Task<IHttpActionResult> EditIdtIctIn([FromBody] EditIdtIctInModel value)
        {
            var Id = Convert.ToInt32(value.depotProdcutValueList[0].IdtIctMasterId);
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {

                try
                {
                    connection.Open();

                    var IdtIctExist = connection.Query<int>("Select * from IdtIcTMaster where ID = @Id", new { Id = Id }).FirstOrDefault();
                    if (IdtIctExist == null)
                    {
                        throw new ProcessException("Selected Idt/Ict not exists");
                    }
                    else
                    {
                        //var p = new firstForm
                        //{
                        var IdtIctType = value.firstForm.IdtIctType;
                        var ReferenceNumber = value.firstForm.ReferenceNumber;
                        var DateOfEntry = value.firstForm.DateOfEntry;
                        var Status = value.status;


                        //};
                        // string updateQuery = @"UPDATE IdtIcTMaster SET IdtIctType=@IdtIctType,ReferenceNumber=@ReferenceNumber,DateOfEntry=@DateOfEntry,Status=@Status where  Id = @Id";
                        string updateQuery = @"UPDATE IdtIcTMaster SET IdtIctType = @IdtIctType,ReferenceNumber=@ReferenceNumber,DateOfEntry=@DateOfEntry,Status=@Status WHERE Id = @Id";

                        var result = connection.Execute(updateQuery, new
                        {
                            IdtIctType,
                            ReferenceNumber,
                            DateOfEntry,
                            Status,
                            Id
                        });
                        var IdtIctMasterId = Id;
                        // var IdtIctDetails = connection.Query<depotProductValueModel>("Select * from IdtIctDetails where IdtIctMasterId=@IdtIctMasterId", new { IdtIctMasterId = IdtIctMasterId }).ToList();
                        for (int i = 0; i < value.depotProdcutValueList.Count; i++)
                        {
                            if (value.depotProdcutValueList[i].Id != 0)
                            {

                                var currentRecord = connection.Query<int>("Select * from IdtIctDetails where ID = @Id", new { Id = value.depotProdcutValueList[i].Id }).FirstOrDefault();
                                //  var isRecordExist
                                var productId = value.depotProdcutValueList[i].productId;
                                var depotId = value.depotProdcutValueList[i].depotId;
                                var quantity = value.depotProdcutValueList[i].quantity;
                                var date = value.depotProdcutValueList[i].date;
                                var DetailsId = value.depotProdcutValueList[i].Id;
                                //var IdtIctMasterId = IdtIctMasterId;


                                //   data.Id = connection.Query<int>(@"UPDATE IdtIctDetails SET IdtIctMasterId=@IdtIctMasterId,productId=@productId,depotId=@depotId,quantity=@quantity,date=@dte) select cast(scope_identity() as int)", p).First();
                                string updateQueryforDetails = @"UPDATE IdtIctDetails SET productId = @productId,depotId=@depotId,quantity=@quantity,date=@date WHERE Id = @DetailsId";
                                var result2 = connection.Execute(updateQueryforDetails, new
                                {
                                    productId,
                                    depotId,
                                    quantity,
                                    date,
                                    DetailsId
                                });
                            }
                            else
                            {
                                var data = new depotProductValueModel
                                {
                                    productId = value.depotProdcutValueList[i].productId,
                                    depotId = value.depotProdcutValueList[i].depotId,
                                    quantity = value.depotProdcutValueList[i].quantity,
                                    date = value.depotProdcutValueList[i].date,
                                    IdtIctMasterId = value.depotProdcutValueList[i].IdtIctMasterId

                                };
                                var id = connection.Query<int>(@"insert IdtIctDetails(IdtIctMasterId,productId,depotId,quantity,date) values (@IdtIctMasterId,@productId,@depotId,@quantity,@date) select cast(scope_identity() as int)", data).First();
                            }
                        }
                        scope.Complete();
                        return Json(new { Message = "Record Updated successfully!" });
                    }
                }
                catch (Exception)
                {
                    connection.BeginTransaction().Rollback();
                    return Json(new { Message = "Error" });
                }

            }
        }

        public async Task<IHttpActionResult> EditIdtIctOut([FromBody] EditIdtIctInModel value)
        {

            var Id = Convert.ToInt32(value.depotProdcutValueList[0].IdtIctMasterId);
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            //   using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {
                try
                {



                    connection.Open();

                    var IdtIctExist = connection.Query<int>("Select * from IdtIcTOutMaster where ID = @Id", new { Id = Id }).FirstOrDefault();
                    if (IdtIctExist == null)
                    {
                        throw new ProcessException("Selected Idt/Ict not exists");
                    }
                    else
                    {
                        //var p = new firstForm
                        //{
                        var IdtIctType = value.firstForm.IdtIctType;
                        var ReferenceNumber = value.firstForm.ReferenceNumber;
                        var DateOfEntry = value.firstForm.DateOfEntry;
                        var Status = value.status;


                        //};
                        // string updateQuery = @"UPDATE IdtIcTMaster SET IdtIctType=@IdtIctType,ReferenceNumber=@ReferenceNumber,DateOfEntry=@DateOfEntry,Status=@Status where  Id = @Id";
                        string updateQuery = @"update IdtIctOutMaster SET IdtIctType = @IdtIctType,ReferenceNumber=@ReferenceNumber,DateOfEntry=@DateOfEntry,Status=@Status WHERE Id = @Id";

                        var result = connection.Execute(updateQuery, new
                        {
                            IdtIctType,
                            ReferenceNumber,
                            DateOfEntry,
                            Status,
                            Id
                        });
                        var IdtIctMasterId = Id;
                        // var IdtIctDetails = connection.Query<depotProductValueModel>("Select * from IdtIctDetails where IdtIctMasterId=@IdtIctMasterId", new { IdtIctMasterId = IdtIctMasterId }).ToList();
                        for (int i = 0; i < value.depotProdcutValueList.Count; i++)
                        {
                            if (value.depotProdcutValueList[i].Id != 0)
                            {

                                var currentRecord = connection.Query<int>("Select * from IdtIctOutDetails where ID = @Id", new { Id = value.depotProdcutValueList[i].Id }).FirstOrDefault();
                                //  var isRecordExist
                                var productId = value.depotProdcutValueList[i].productId;
                                var depotId = value.depotProdcutValueList[i].depotId;
                                var quantity = value.depotProdcutValueList[i].quantity;
                                var date = value.depotProdcutValueList[i].date;
                                var DetailsId = value.depotProdcutValueList[i].Id;
                                //var IdtIctMasterId = IdtIctMasterId;


                                //   data.Id = connection.Query<int>(@"UPDATE IdtIctDetails SET IdtIctMasterId=@IdtIctMasterId,productId=@productId,depotId=@depotId,quantity=@quantity,date=@dte) select cast(scope_identity() as int)", p).First();
                                string updateQueryforDetails = @"UPDATE IdtIctOutDetails SET productId = @productId,depotId=@depotId,quantity=@quantity,date=@date WHERE Id = @DetailsId";
                                var result2 = connection.Execute(updateQueryforDetails, new
                                {
                                    productId,
                                    depotId,
                                    quantity,
                                    date,
                                    DetailsId
                                });
                            }
                            else
                            {
                                var data = new depotProductValueModel
                                {
                                    productId = value.depotProdcutValueList[i].productId,
                                    depotId = value.depotProdcutValueList[i].depotId,
                                    quantity = value.depotProdcutValueList[i].quantity,
                                    date = value.depotProdcutValueList[i].date,
                                    IdtIctMasterId = value.depotProdcutValueList[i].IdtIctMasterId

                                };
                                var id = connection.Query<int>(@"insert IdtIctOutDetails(IdtIctMasterId,productId,depotId,quantity,date) values (@IdtIctMasterId,@productId,@depotId,@quantity,@date) select cast(scope_identity() as int)", data).First();
                            }
                        }
                        // scope.Complete();
                        return Json(new { Message = "Record Updated successfully!" });
                    }
                }
                catch (Exception)
                {

                    connection.BeginTransaction().Rollback();
                    return Json(new { Message = "Error" });
                }


            }
        }
        private string DataTableToJSONWithJSONNet(DataTable table)
        {
            string JSONString = string.Empty;
            JSONString = JsonConvert.SerializeObject(table);
            return JSONString;
        }
        [HttpGet]
        public List<InData> viewIdtReferenceNumber()
        {
            //  List<firstForm> IdtIctInList = new List<firstForm>();
            List<InData> data = new List<InData>();

            using (var connection = new SqlConnection(sqlConnectionString))
            {
                var IdtrefNumberList = connection.Query<firstForm>("Select * from IdtIcTMaster WHERE Status='Completed'").ToList();
                //   var list = DataTableToJSONWithJSONNet(refNumberList);
                // dynamic json = JsonConvert.DeserializeObject(list);
                for (int i = 0; i < IdtrefNumberList.Count; i++)
                {
                    InData refList = new InData();
                    refList.Id = IdtrefNumberList[i].Id;
                    refList.ReferenceNumber = IdtrefNumberList[i].ReferenceNumber;
                    refList.Type = IdtrefNumberList[i].IdtIctType;
                    data.Add(refList);
                }
                var cpLprefNumberList = connection.Query<CPLTMaster>("Select * from CPLTMaster WHERE Status='Completed'").ToList();
                for (int i = 0; i < cpLprefNumberList.Count; i++)
                {
                    InData refList = new InData();
                    refList.Id = cpLprefNumberList[i].Id;
                    refList.ReferenceNumber = cpLprefNumberList[i].ReferenceNumber;
                    refList.Type = cpLprefNumberList[i].Type;
                    data.Add(refList);
                }
                return data;


            }
        }
    }

}

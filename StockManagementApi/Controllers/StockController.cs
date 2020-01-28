using Dapper;
using StockManagementApi.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;

namespace StockManagementApi.Controllers
{
    public class StockController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        [HttpPost]
        [ResponseType(typeof(Product))]
        [Authorize(Roles = "17")]
        public async Task<IHttpActionResult> AddStock([FromBody]StockIn stockIn)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();
                var identity = (ClaimsIdentity)User.Identity;
                var userId = identity.Claims.Where(c => c.Type == ClaimTypes.Sid)
                   .Select(c => c.Value).SingleOrDefault();
                List<int> BatchIds = new List<int>();
                foreach (var item in stockIn.Batch)
                {
                    var batchDetails = new Batch
                    {
                        BatchName = item.BatchName,
                        Quantity = item.Quantity,
                        WarehouseSectionId = item.WarehouseSectionId,
                        MfgDate = item.MfgDate,
                        ExpDate = item.ExpDate,
                        EslDate = item.EslDate,
                        AddedBy=userId,
                        AddedOn=DateTime.Now,
                        IsActive=item.IsActive

                    };
                    batchDetails.BatchId = connection.Query<int>(@"insert Stock_BatchMaster(BatchName,Quantity,WarehouseSectionId,MfgDate,ExpDate,EslDate,IsActive,
                        AddedOn,AddedBy) values (@BatchName,@Quantity,@WarehouseSectionId,@MfgDate,@ExpDate,@EslDate,@IsActive,
                        @AddedOn,@AddedBy) select cast(scope_identity() as int)", batchDetails).First();
                    BatchIds.Add(batchDetails.BatchId);
                }

                var stockInDetails = new Stock
                {
                    LotBatchId = String.Join(",", BatchIds),
                    DateOfReceipt = stockIn.stock.DateOfReceipt,
                    CrvNumber = stockIn.stock.CrvNumber,
                    Description = stockIn.stock.Description,
                    ReceivedFrom = stockIn.stock.ReceivedFrom,
                    PackingMaterialName = stockIn.stock.PackingMaterialName,
                    OriginalManufacture = stockIn.stock.OriginalManufacture,
                    GenericName = stockIn.stock.GenericName,
                    Weight = stockIn.stock.Weight,
                    AddedBy = stockIn.stock.AddedBy,
                    IsActive = stockIn.stock.IsActive
                };
                 stockInDetails.StockInId=connection.Query<int>(@"insert StockIn(LotBatchId,DateOfReceipt,CrvNumber,Description,ReceivedFrom,
                                         PackingMaterialName,OriginalManufacture,GenericName,Weight,AddedBy,IsActive) select cast(scope_identity() as int)", stockInDetails).First();
                return Json(new { Message = "Record Inserted Successfully" });


               


            }
        }
    }
}

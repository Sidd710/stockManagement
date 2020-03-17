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
        [ResponseType(typeof(StockIn))]

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
                int quantity = 0;
                foreach (var item in stockIn.Batch)
                {
                    var batchDetails = new Batch
                    {
                        BatchName = item.BatchName,
                        Quantity = item.Quantity,
                        WarehouseID = item.WarehouseID,
                        MfgDate = item.MfgDate,
                        ExpDate = item.ExpDate,
                        ESL = item.ESL,
                        AvailableQuantity = item.AvailableQuantity,
                        BatchCode = item.BatchCode,
                        BatchNumber = item.BatchNumber



                    };
                    quantity = quantity + item.Quantity;
                    batchDetails.BatchId = connection.Query<int>(@"insert BatchMaster(BatchName,Quantity,WarehouseID,MFGDate,EXPDate,ESL) values (@BatchName,@Quantity,@WarehouseID,@MFGDate,@EXPDate,@ESL) select cast(scope_identity() as int)", batchDetails).First();
                    BatchIds.Add(batchDetails.BatchId);
                }
                var receivedFrom = string.Empty;
                if(stockIn.stock.IsCP!=null &&stockIn.stock.IsCP != "")
                {
                    receivedFrom = stockIn.stock.IsCP;
                }
                else
                {
                    receivedFrom = stockIn.stock.IsLP;
                }
                var TransferedBy = string.Empty;
                if (stockIn.stock.IIDT != null && stockIn.stock.IIDT != "")
                {
                    TransferedBy = stockIn.stock.IIDT;
                }
                else
                {
                    TransferedBy = stockIn.stock.IICT;
                }

                var stockInDetails = new Stock
                {
                    BatchIdFromMobile = String.Join(",", BatchIds),
                    RecievedOn = stockIn.stock.RecievedOn,
                    CRVNo = stockIn.stock.CRVNo,
                    Remarks = stockIn.stock.Remarks,
                    RecievedFrom = receivedFrom,
                    PackingMaterial = stockIn.stock.PackingMaterial,
                    OriginalManf = stockIn.stock.OriginalManf,
                    GenericName = stockIn.stock.GenericName,
                    Weight = stockIn.stock.Weight,
                    AddedOn = DateTime.Now,
                    SupplierId=stockIn.stock.SupplierId,
                    //  IsActive = stockIn.stock.IsActive,
                    ProductId = stockIn.stock.ProductId,
                    Quantity = stockIn.stock.Quantity,
                    IsFromMobile=stockIn.stock.IsFromMobile,
                    ATNo=stockIn.stock.ATNo,
                    OtherSupplier=stockIn.stock.OtherSupplier,
                    TransferedBy=TransferedBy,
                    SampleSent=stockIn.stock.SampleSent,
                    SupplierNo=stockIn.stock.SupplierNo


                };
                //var productQuantity = new ProductQuantity
                //{
                //    ProductId = stockIn.stock.ProductId,
                //    Quantity = quantity

                //};
                stockInDetails.StockInId = connection.Query<int>(@"insert StockMaster(BatchIdFromMobile,RecievedOn,CRVNo,Remarks,RecievedFrom,
                                         PackingMaterial,OriginalManf,GenericName,Weight,AddedOn,SupplierId,ProductId,Quantity,IsFromMobile,ATNo,OtherSupplier,TransferedBy,SampleSent,SupplierNo
) values (@BatchIdFromMobile,@RecievedOn,@CRVNo,@Remarks,@RecievedFrom,
                                         @PackingMaterial,@OriginalManf,@GenericName,@Weight,@AddedOn,@SupplierId,@ProductId,@Quantity,@IsFromMobile,@ATNo,@OtherSupplier,@TransferedBy,@SampleSent,@SupplierNo) select cast(scope_identity() as int)", stockInDetails).First();

                //var productExist = connection.Query<ProductQuantity>("Select * from Stock_QuantityMaster where ProductId = @ProductId", new { ProductId = stockIn.stock.ProductId }).FirstOrDefault();

                //if (productExist == null)
                //{
                //    var id = connection.Query<int>(@"insert Stock_QuantityMaster(ProductId,Quantity)values(@ProductId,@Quantity)select cast(scope_identity() as int)", productQuantity).First();

                //}
                //else
                //{
                //    int totalQuantity = productExist.Quantity + quantity;
                //    // var id = connection.Query<int>(@"update Stock_QuantityMaster set Quantity = @totalQuantity where ProductId = @ProductId", new { totalQuantity, ProductId = stockIn.stock.ProductId }).First();
                //    string updateQuery = @"UPDATE Stock_QuantityMaster SET Quantity = @totalQuantity WHERE ProductId = @ProductId";

                //    var result = connection.Execute(updateQuery, new
                //    {
                //        totalQuantity,
                //        stockIn.stock.ProductId,

                //    });

                //}


                return Json(new { Message = "Record Inserted Successfully" });





            }
        }

        public async Task<IHttpActionResult> StockOut([FromBody] StockOut stockOut)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            using (var connection = new SqlConnection(sqlConnectionString))
            {
                try
                {
                    connection.Open();

                    var lotExist = connection.Query<Batch>("Select * from Stock_BatchMaster where BatchId = @BatchId", new { BatchId = stockOut.LotBatchId }).FirstOrDefault();
                    if (lotExist == null)
                    {
                        return Json(new { Message = "Please Select Valid Lot/Batch" });
                    }
                    else if (lotExist.AvailableQuantity <= stockOut.Quantity)
                    {
                        return Json(new { Message = "Quantity Not Available" });

                    }
                    else
                    {
                        var identity = (ClaimsIdentity)User.Identity;
                        var userId = identity.Claims
                            .Where(c => c.Type == ClaimTypes.Sid)
                            .Select(c => c.Value);
                        var p = new StockOut { LotBatchId = stockOut.LotBatchId, DateOfDispatch = stockOut.DateOfDispatch, Quantity = stockOut.Quantity };
                        p.LotBatchId = connection.Query<int>(@"insert Stock_StockOut(LotBatchId,DateOfDispatch,Quantity) values (@LotBatchId,@DateOfDispatch,@Quantity) select cast(scope_identity() as int)", p).First();
                        int availableQuantity = lotExist.AvailableQuantity - stockOut.Quantity;
                        string updateQuery = @"UPDATE Stock_BatchMaster SET AvailableQuantity = @availableQuantity WHERE BatchId = @BatchId";

                        var result = connection.Execute(updateQuery, new
                        {
                            availableQuantity,
                            BatchId = stockOut.LotBatchId,

                        });

                        return Json(new { Message = "Stock quantity updated successfully" });


                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }



            }
        }

        [HttpGet]
        public List<ViewStockIn> ViewStockIn()
        {
            List<Stock> StockInList = new List<Stock>();
            List<ViewStockIn> viewStockIns = new List<ViewStockIn>();
            using (var connection = new SqlConnection(sqlConnectionString))
            {

                connection.Open();
                StockInList = connection.Query<Stock>("Select * from Stock_StockIn").ToList();
                foreach (var item in StockInList)
                {
                    ViewStockIn viewStockInDetails = new ViewStockIn();
                    string[] BatchId = item.BatchIdFromMobile.Split(',');
                    List<Batch> batch = new List<Batch>();


                    foreach (var batchIds in BatchId)
                    {
                        viewStockInDetails.Batch = new List<Batch>();

                        var currentBatchDetails = connection.Query<Batch>("Select * from Stock_BatchMaster where BatchId = @value", new { value = batchIds }).FirstOrDefault();
                        Batch tempBatchDetails = new Batch();
                        tempBatchDetails.BatchId = currentBatchDetails.BatchId;
                        tempBatchDetails.BatchName = currentBatchDetails.BatchName;
                        tempBatchDetails.ESL = currentBatchDetails.ESL;
                        tempBatchDetails.Quantity = currentBatchDetails.Quantity;
                        tempBatchDetails.WarehouseID = currentBatchDetails.WarehouseID;


                        viewStockInDetails.Batch.Add(tempBatchDetails);
                    }
                    var currentProduct = connection.Query<Product>("Select * from ProductMaster where Product_ID = @value", new { value = item.ProductId }).FirstOrDefault();
                    viewStockInDetails.ProductName = currentProduct.Product_Name;
                    var currentCategory = connection.Query<Categories>("Select * from CategoryMaster where ID = @value", new { value = currentProduct.Category_Id }).FirstOrDefault();
                    viewStockInDetails.CategoryName = currentCategory.Category_Name;
                    viewStockInDetails.LotBatchId = item.BatchIdFromMobile;
                    viewStockInDetails.ProductId = item.ProductId;
                    viewStockInDetails.Description = item.Remarks;
                    viewStockInDetails.DateOfReceipt = item.RecievedOn;
                    viewStockIns.Add(viewStockInDetails);

                }
                connection.Close();
            }
            return viewStockIns;

        }
    }
}

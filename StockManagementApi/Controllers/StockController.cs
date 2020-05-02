﻿using Dapper;
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
                        AvailableQuantity = item.Quantity,
                        BatchCode = item.BatchCode,
                        BatchNo = item.BatchNo



                    };
                    quantity = quantity + item.Quantity;
                    batchDetails.BatchId = connection.Query<int>(@"insert BatchMaster(BatchName,Quantity,WarehouseID,MFGDate,EXPDate,ESL,AvailableQuantity,BatchCode,BatchNo) values (@BatchName,@Quantity,@WarehouseID,@MFGDate,@EXPDate,@ESL,@AvailableQuantity,@BatchCode,@BatchNo) select cast(scope_identity() as int)", batchDetails).First();
                    BatchIds.Add(batchDetails.BatchId);
                }
               // var receivedFrom = string.Empty;
                //if (stockIn.stock.IsCP != null && stockIn.stock.IsCP != "")
                //{
                //    receivedFrom = stockIn.stock.IsCP;
                //}
                //else if(stockIn.stock.IsLP!=null && stockIn.stock.IsLP!="")
                //{
                //    receivedFrom = stockIn.stock.IsLP;
                //}
                //else if (stockIn.stock.IsLT != null && stockIn.stock.IsLT != "")
                //{
                //    receivedFrom = stockIn.stock.IsLT;
                //}
                //var TransferedBy = string.Empty;
                //if (stockIn.stock.IIDT != null && stockIn.stock.IIDT != "")
                //{
                //    TransferedBy = "IDT";
                //}
                //else
                //{
                //    TransferedBy = "ICT";
                //}

                var stockInDetails = new Stock
                {
                    BatchIdFromMobile = String.Join(",", BatchIds),
                    RecievedOn = stockIn.stock.RecievedOn,
                    CRVNo = stockIn.stock.CRVNo,
                    Remarks = stockIn.stock.Remarks,
                    RecievedFrom = stockIn.stock.RecievedFrom,
                    PackingMaterial = stockIn.stock.PackingMaterial,
                    OriginalManf = stockIn.stock.OriginalManf,
                    GenericName = stockIn.stock.GenericName,
                    Weight = stockIn.stock.Weight,
                    AddedOn = DateTime.Now,
                    SupplierId = stockIn.stock.SupplierId,
                    //  IsActive = stockIn.stock.IsActive,
                    ProductId = stockIn.stock.ProductId,
                    Quantity = stockIn.stock.Quantity,
                    IsFromMobile = stockIn.stock.IsFromMobile,
                    ATNo = stockIn.stock.ATNo,
                    OtherSupplier = stockIn.stock.OtherSupplier,
                  //  TransferedBy = TransferedBy,
                    SampleSent = stockIn.stock.SampleSent,
                    SupplierNo = stockIn.stock.SupplierNo,
                    DepotId=stockIn.stock.DepotId,
                    IsCP=stockIn.stock.IsCP,
                    IsLP = stockIn.stock.IsLP,
                    IsIDT = stockIn.stock.IsIDT,
                    IsICT = stockIn.stock.IsICT,


                };
                //var productQuantity = new ProductQuantity
                //{
                //    ProductId = stockIn.stock.ProductId,
                //    Quantity = quantity

                //};
                stockInDetails.StockInId = connection.Query<int>(@"insert StockMaster(BatchIdFromMobile,RecievedOn,CRVNo,Remarks,RecievedFrom,
                                         PackingMaterial,OriginalManf,GenericName,Weight,AddedOn,SupplierId,ProductId,Quantity,IsFromMobile,ATNo,OtherSupplier,TransferedBy,SampleSent,SupplierNo,DepotId,IsCP,IsLP,IsIDT,IsICT
) values (@BatchIdFromMobile,@RecievedOn,@CRVNo,@Remarks,@RecievedFrom,
                                         @PackingMaterial,@OriginalManf,@GenericName,@Weight,@AddedOn,@SupplierId,@ProductId,@Quantity,@IsFromMobile,@ATNo,@OtherSupplier,@TransferedBy,@SampleSent,@SupplierNo,@DepotId,@IsCP,@IsLP,@IsIDT,@IsICT) select cast(scope_identity() as int)", stockInDetails).First();

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

        public async Task<IHttpActionResult> StockOut([FromBody] StockOutParameter stockOut)
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
                    foreach (var item in stockOut.stockOutBatchList)
                    {
                        var lotExist = connection.Query<Batch>("Select * from BatchMaster where BID = @BID", new { BID = item.BID }).FirstOrDefault();
                        if (lotExist == null)
                        {
                            return Json(new { Message = "Please Select Valid Lot/Batch" });
                        }
                        else if (lotExist.AvailableQuantity < item.Quantity)
                        {
                            return Json(new { Message = "Quantity Not Available FOr Batch Id :- " + item.BID });

                        }

                    }
                    foreach (var item in stockOut.stockOutBatchList)
                    {
                        //var p = new StockOut { Remarks=st DateOfDispatch = stockOut.stockOut.DateOfDispatch, Quantity = stockOut.stockOut.Quantity };
                        //p.s = connection.Query<int>(@"insert Stock_StockOut(LotBatchId,DateOfDispatch,Quantity) values (@LotBatchId,@DateOfDispatch,@Quantity) select cast(scope_identity() as int)", p).First();
                        var lotExist = connection.Query<Batch>("Select * from BatchMaster where BID = @BID", new { BID = item.BID }).FirstOrDefault();
                        int availableQuantity = lotExist.AvailableQuantity - item.Quantity;
                        string updateQuery = @"UPDATE BatchMaster SET AvailableQuantity = @availableQuantity WHERE BID = @BID";
                        var p = new StockOut
                        {
                            Remarks = stockOut.stockOut.Remarks,
                            DateOfDispatch = stockOut.stockOut.DateOfDispatch,
                            BatchId = item.BID,
                            Quantity = item.Quantity,
                            ProductId = stockOut.stockOut.ProductId,
                            VoucherNumber = stockOut.stockOut.VoucherNumber,
                            StockType = stockOut.stockOut.StockType,
                            IsAWS=stockOut.stockOut.IsAWS,
                            IsICT = stockOut.stockOut.IsICT,
                            IsIDT = stockOut.stockOut.IsIDT,
                            DepotId = stockOut.stockOut.DepotId,
                            UnitId = stockOut.stockOut.UnitId,
                        };
                        var result = connection.Execute(updateQuery, new
                        {
                            availableQuantity,
                            item.BID,

                        });
                        p.StockOutId = connection.Query<int>(@"insert StockOutMaster(Remarks,DateOfDispatch,BatchId,Quantity,ProductId,VoucherNumber,StockType,IsAWS,IsICT,IsIDT,DepotId,UnitId) values (@Remarks,@DateOfDispatch,@BatchId,@Quantity,@ProductId,@VoucherNumber,@StockType,@IsAWS,@IsICT,@IsIDT,@DepotId,@UnitId) select cast(scope_identity() as int)", p).First();




                    }
                    return Json(new { Message = "Stock quantity updated successfully" });


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
                StockInList = connection.Query<Stock>("Select * from StockMaster").ToList();
                foreach (var item in StockInList)
                {
                    ViewStockIn viewStockInDetails = new ViewStockIn();
                    string[] BatchId = item.BatchIdFromMobile.Split(',');
                    List<Batch> batch = new List<Batch>();


                    foreach (var batchIds in BatchId)
                    {
                        viewStockInDetails.Batch = new List<BatchDetails>();

                        var currentBatchDetails = connection.Query<BatchDetails>("Select * from BatchMaster where BID = @value", new { value = batchIds }).FirstOrDefault();
                        BatchDetails tempBatchDetails = new BatchDetails();
                        tempBatchDetails.BID = currentBatchDetails.BID;
                        tempBatchDetails.BatchName = currentBatchDetails.BatchName;
                        tempBatchDetails.Esl = currentBatchDetails.Esl;
                        tempBatchDetails.Quantity = currentBatchDetails.Quantity;
                        tempBatchDetails.WarehouseID = currentBatchDetails.WarehouseID;
                        tempBatchDetails.AvailableQuantity = currentBatchDetails.AvailableQuantity;
                        tempBatchDetails.SampleSentQty = currentBatchDetails.SampleSentQty;
                        tempBatchDetails.MFGDate = currentBatchDetails.MFGDate;
                        tempBatchDetails.EXPDate = currentBatchDetails.EXPDate;
                        tempBatchDetails.Esl = currentBatchDetails.Esl;

                        viewStockInDetails.Batch.Add(tempBatchDetails);
                    }
                    var currentProduct = connection.Query<ProductList>("Select * from ProductMaster where Product_ID = @value", new { value = item.ProductId }).FirstOrDefault();
                    viewStockInDetails.ProductName = currentProduct.Product_Name;
                    
                    var currentCategory = connection.Query<Category>("Select * from CategoryMaster where ID = @value", new { value = currentProduct.Category_Id }).FirstOrDefault();
                    viewStockInDetails.CategoryName = currentCategory.Category_Name;
                    viewStockInDetails.LotBatchId = item.BatchIdFromMobile;
                    viewStockInDetails.ProductId = item.ProductId;
                    viewStockInDetails.Description = item.Remarks;
                    viewStockInDetails.DateOfReceipt = item.RecievedOn;
                    viewStockInDetails.CRVNo = item.CRVNo;
                    viewStockInDetails.Quantity = item.Quantity;
                    viewStockInDetails.AccountingUnit = currentProduct.productUnit;
                    if (item.IsCP == true)
                    {
                        viewStockInDetails.CPLPNumber = "CP-" + item.Remarks;
                    }
                    if (item.IsLP == true)
                    {
                        viewStockInDetails.CPLPNumber = "LP-" + item.Remarks;
                    }
                    if (item.IsLT == true)
                    {
                        viewStockInDetails.CPLPNumber = "LT-" + item.Remarks;
                    }
                    if (item.IsIDT == true)
                    {
                        viewStockInDetails.IDTICTNumber = "IDT-" + item.Remarks;
                    }
                    if (item.IsICT == true)
                    {
                        viewStockInDetails.IDTICTNumber = "ICT-" + item.Remarks;
                    }
                    
                    viewStockIns.Add(viewStockInDetails);

                }
                connection.Close();
            }
            return viewStockIns;

        }

        [HttpGet]
        public List<ViewStockOut> ViewStockOut()
        {
            List<ViewStockOut> StockOutList = new List<ViewStockOut>();
            List<ViewStockOut> StockOutItem = new List<ViewStockOut>();
            using (var connection = new SqlConnection(sqlConnectionString))
            {

                connection.Open();
                StockOutList = connection.Query<ViewStockOut>("Select * from StockOutMaster").ToList();
                foreach (var item in StockOutList)
                {
                    ViewStockOut viewStockOutDetails = new ViewStockOut();
                    BatchDetails batchDetails = new BatchDetails();
                    int BID = item.BatchId;
                    // List<Batch> batch = new List<Batch>();


                    var currentBatchDetails = connection.Query<BatchDetails>("Select * from BatchMaster where BID = @BID", new { BID = BID }).FirstOrDefault();
                    BatchDetails tempBatchDetails = new BatchDetails();
                    viewStockOutDetails.Batch = new List<BatchDetails>();
                    tempBatchDetails.BID = currentBatchDetails.BID;
                    tempBatchDetails.BatchName = currentBatchDetails.BatchName;
                    tempBatchDetails.Esl = currentBatchDetails.Esl;
                    tempBatchDetails.Quantity = currentBatchDetails.Quantity;
                    tempBatchDetails.WarehouseID = currentBatchDetails.WarehouseID;
                    tempBatchDetails.AvailableQuantity = currentBatchDetails.AvailableQuantity;
                    tempBatchDetails.SampleSentQty = currentBatchDetails.SampleSentQty;
                    tempBatchDetails.MFGDate = currentBatchDetails.MFGDate;
                    tempBatchDetails.EXPDate = currentBatchDetails.EXPDate;
                    tempBatchDetails.Esl = currentBatchDetails.Esl;

                    viewStockOutDetails.Batch.Add(tempBatchDetails);
                    var currentProduct = connection.Query<ProductList>("Select * from ProductMaster where Product_ID = @value", new { value = item.ProductId }).FirstOrDefault();
                    viewStockOutDetails.ProductName = currentProduct.Product_Name;
                    var currentCategory = connection.Query<Category>("Select * from CategoryMaster where ID = @value", new { value = currentProduct.Category_Id }).FirstOrDefault();
                    viewStockOutDetails.CategoryName = currentCategory.Category_Name;
                    // viewStockOutDetails.BatchId = item.BatchId;
                    viewStockOutDetails.BatchName = currentBatchDetails.BatchName;
                    viewStockOutDetails.ProductId = item.ProductId;
                    viewStockOutDetails.Remarks = item.Remarks;
                    viewStockOutDetails.Quantity = item.Quantity;
                    viewStockOutDetails.DateofDispatch = item.DateofDispatch;
                    viewStockOutDetails.StockType = item.StockType;
                    viewStockOutDetails.VoucherNumber = item.VoucherNumber;
                    viewStockOutDetails.AccountingUnit = currentProduct.productUnit;
                    if (item.IsAWS == true)
                    {
                        viewStockOutDetails.IDTReferenceNumber = "AWS-" + item.Remarks;
                    }
                    if (item.IsICT == true)
                    {
                        viewStockOutDetails.IDTReferenceNumber = "ICT-" + item.Remarks;
                    }
                    if (item.IsIDT == true)
                    {
                        viewStockOutDetails.IDTReferenceNumber = "IDT-" + item.Remarks;
                    }
                    StockOutItem.Add(viewStockOutDetails);

                }
                connection.Close();
            }
            return StockOutItem;

        }

        [HttpGet]
        public List<AvailableStock> AvailableStock()
        {
            List<Stock> StockInList = new List<Stock>();
            List<AvailableStock> viewStockIns = new List<AvailableStock>();
            using (var connection = new SqlConnection(sqlConnectionString))
            {

                connection.Open();
                StockInList = connection.Query<Stock>("Select * from StockMaster").ToList();
                foreach (var item in StockInList)
                {
                    AvailableStock viewStockInDetails = new AvailableStock();
                    string[] BatchId = item.BatchIdFromMobile.Split(',');
                    List<Batch> batch = new List<Batch>();


                    foreach (var batchIds in BatchId)
                    {
                        viewStockInDetails.Batch = new List<BatchDetails>();

                        var currentBatchDetails = connection.Query<BatchDetails>("Select * from BatchMaster where BID = @value", new { value = batchIds }).FirstOrDefault();
                        BatchDetails tempBatchDetails = new BatchDetails();
                        tempBatchDetails.BID = currentBatchDetails.BID;
                        tempBatchDetails.BatchName = currentBatchDetails.BatchName;
                        tempBatchDetails.Esl = currentBatchDetails.Esl;
                        tempBatchDetails.AvailableQuantity = currentBatchDetails.AvailableQuantity;
                        tempBatchDetails.WarehouseID = currentBatchDetails.WarehouseID;
                        tempBatchDetails.EXPDate = currentBatchDetails.EXPDate;
                        tempBatchDetails.WarehouseNo = currentBatchDetails.WarehouseNo;

                        viewStockInDetails.Batch.Add(tempBatchDetails);
                    }
                    var currentProduct = connection.Query<ProductList>("Select * from ProductMaster where Product_ID = @value", new { value = item.ProductId }).FirstOrDefault();
                    viewStockInDetails.ProductName = currentProduct.Product_Name;
                    var currentCategory = connection.Query<Category>("Select * from CategoryMaster where ID = @value", new { value = currentProduct.Category_Id }).FirstOrDefault();
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

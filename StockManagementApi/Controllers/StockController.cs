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
using System.Transactions;
using System.Web.Http;
using System.Web.Http.Description;
using System.Web.UI.WebControls;

namespace StockManagementApi.Controllers
{
    public class StockController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        [HttpPost]
        [ResponseType(typeof(StockIn))]

        public async Task<IHttpActionResult> AddStock([FromBody] StockIn stockIn)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                using (TransactionScope scope = new TransactionScope())

                using (var connection = new SqlConnection(sqlConnectionString))
                {
                    connection.Open();
                    Nullable<int> IdtMasterId = 0;
                    Nullable<int> CptMasterId = 0;
                    if (stockIn.stock.IsIDT || stockIn.stock.IsICT)
                    {
                        var IdtMaster = connection.Query<firstForm>("Select * from IdtIcTMaster where ReferenceNumber = @ReferenceNumber", new { ReferenceNumber = stockIn.stock.ReferenceNumber }).FirstOrDefault();
                        if (IdtMaster == null)
                        {
                            return Json(new { Message = "Please select valid Idt Reference Number" });
                        }
                        else
                        {
                            var IdtDetails = connection.Query<depotProductValueModel>("Select * from IdtIctDetails where IdtIctMasterId=@IdtIctMasterId", new { IdtIctMasterId = IdtMaster.Id }).ToList();
                            // IsProduct Exist
                            var isProduct = IdtDetails.Find(t => t.productId == stockIn.stock.ProductId);
                            var isDepot = IdtDetails.Find(t => t.depotId == stockIn.stock.DepotId);
                            if (isProduct == null || isDepot == null)
                            {
                                return Json(new { Message = "Please select valid depot and product" });
                            }
                            else
                            {
                                // FindCurrentIdtDetails
                                var currentIdtDetails = IdtDetails.Find(t => t.depotId == stockIn.stock.DepotId && t.productId == stockIn.stock.ProductId);
                                if (stockIn.stock.Quantity > Convert.ToInt32(currentIdtDetails.AvailableQuantity))
                                {
                                    return Json(new { Message = "Quantity Not available" });
                                }

                                var NewAvailableQuantity = Convert.ToInt32(currentIdtDetails.AvailableQuantity) - stockIn.stock.Quantity;
                                var ModifiedOn = DateTime.Now;
                                var Id = currentIdtDetails.Id;
                                IdtMasterId = IdtMaster.Id;
                                string updateQuery = @"UPDATE IdtIctDetails SET AvailableQuantity=@NewAvailableQuantity,ModifiedOn=@ModifiedOn where  Id = @Id";
                                var Status = "InProgress";
                                //FInd available Quanity



                                var result = connection.Execute(updateQuery, new
                                {
                                    NewAvailableQuantity,
                                    ModifiedOn,
                                    Id
                                });
                                //var results2 = connection.Execute(updateMaster, new
                                //{
                                //    Status,
                                //    Id

                                //});


                            }


                        }

                    }
                    else
                    {
                        var CPMaster = connection.Query<CPLTMaster>("Select * from CPLTMaster where ReferenceNumber = @ReferenceNumber", new { ReferenceNumber = stockIn.stock.ReferenceNumber }).FirstOrDefault();
                        if (CPMaster == null)
                        {
                            return Json(new { Message = "Please select valid CP Reference Number" });
                        }
                        else
                        {
                            var CpDetails = connection.Query<CPLTDetails>("Select * from CPLTDetails where CPLTId = @CPLTId", new { CPLTId = CPMaster.Id }).ToList();
                            // IsProduct Exist
                            var isProduct = CpDetails.Find(t => t.ProdId == stockIn.stock.ProductId);
                            //  var isDepot = IdtDetails.Find(t => t.depotId == stockIn.stock.DepotId);
                            if (isProduct == null)
                            {
                                return Json(new { Message = "Please select valid depot and product" });
                            }
                            else
                            {
                                // FindCurrentCptDetails
                                var currentCPTDetails = CpDetails.Find(t => t.ProdId == stockIn.stock.ProductId);
                                if (stockIn.stock.Quantity > Convert.ToInt32(currentCPTDetails.AvailableQuantity))
                                {
                                    return Json(new { Message = "Quantity Not available" });
                                }

                                var NewAvailableQuantity = Convert.ToInt32(currentCPTDetails.AvailableQuantity) - stockIn.stock.Quantity;
                                var ModifiedOn = DateTime.Now;
                                var Id = currentCPTDetails.Id;
                                CptMasterId = CPMaster.Id;
                                string updateQuery = @"UPDATE CPLTDetails SET AvailableQuantity=@NewAvailableQuantity,ModifiedOn=@ModifiedOn where  Id = @Id";
                                // string updateQuery = @"UPDATE IdtIcTMaster SET IdtIctType = @IdtIctType,ReferenceNumber=@ReferenceNumber,DateOfEntry=@DateOfEntry,Status=@Status WHERE Id = @Id";

                                var result = connection.Execute(updateQuery, new
                                {
                                    NewAvailableQuantity,
                                    ModifiedOn,
                                    Id
                                });

                            }


                        }
                    }
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
                            BatchNo = item.BatchNo,
                            AddedOn = DateTime.Now,
                            SectionID = item.SectionID,



                        };
                        quantity = quantity + item.Quantity;
                        batchDetails.BatchId = connection.Query<int>(@"insert BatchMaster(BatchName,Quantity,WarehouseID,MFGDate,EXPDate,ESL,AvailableQuantity,BatchCode,BatchNo,AddedOn,SectionID) values (@BatchName,@Quantity,@WarehouseID,@MFGDate,@EXPDate,@ESL,@AvailableQuantity,@BatchCode,@BatchNo,@AddedOn,@SectionID) select cast(scope_identity() as int)", batchDetails).First();
                        BatchIds.Add(batchDetails.BatchId);
                    }
                    if (CptMasterId == 0)
                    {

                    }

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
                        DepotId = stockIn.stock.DepotId,
                        IsCP = stockIn.stock.IsCP,
                        IsLP = stockIn.stock.IsLP,
                        IsIDT = stockIn.stock.IsIDT,
                        IsICT = stockIn.stock.IsICT,
                        IdtMasterId = IdtMasterId == 0 ? null : IdtMasterId,
                        CptMasterId = CptMasterId == 0 ? null : CptMasterId


                    };


                    stockInDetails.StockInId = connection.Query<int>(@"insert StockMaster(BatchIdFromMobile,RecievedOn,CRVNo,Remarks,RecievedFrom,
                                         PackingMaterial,OriginalManf,GenericName,Weight,AddedOn,SupplierId,ProductId,Quantity,IsFromMobile,ATNo,OtherSupplier,TransferedBy,SampleSent,SupplierNo,DepotId,IsCP,IsLP,IsIDT,IsICT,IdtMasterId,CptMasterId
) values (@BatchIdFromMobile,@RecievedOn,@CRVNo,@Remarks,@RecievedFrom,
                                         @PackingMaterial,@OriginalManf,@GenericName,@Weight,@AddedOn,@SupplierId,@ProductId,@Quantity,@IsFromMobile,@ATNo,@OtherSupplier,@TransferedBy,@SampleSent,@SupplierNo,@DepotId,@IsCP,@IsLP,@IsIDT,@IsICT,@IdtMasterId,@CptMasterId) select cast(scope_identity() as int)", stockInDetails).First();

                    //Update IdtMaster

                    scope.Complete();
                    return Json(new { Message = "Record Inserted Successfully" });


                }
            }
            catch (Exception ex)
            {

                throw ex;
            }





        }

        public async Task<IHttpActionResult> StockOut([FromBody] StockOutParameter stockOut)
        {
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
                    Nullable<int> IdtMasterId = 0;
                    var IdtMaster = connection.Query<firstForm>("Select * from IdtIctOutMaster where ReferenceNumber = @ReferenceNumber", new { ReferenceNumber = stockOut.stockOut.ReferenceNumber }).FirstOrDefault();
                    if (IdtMaster == null)
                    {
                        return Json(new { Message = "Please select valid Idt Reference Number" });
                    }
                    else
                    {
                        var IdtDetails = connection.Query<unitProductValueModel>("Select * from IdtIctOutDetails where IdtIctOutMasterId=@IdtIctOutMasterId", new { IdtIctOutMasterId = IdtMaster.Id }).ToList();
                        // IsProduct Exist
                        var isProduct = IdtDetails.Find(t => t.productId == stockOut.stockOut.ProductId);
                        if (stockOut.stockOut.IsIDT)
                        {
                            if (IdtMaster.IdtIctType != "IDT")
                            {
                                return Json(new { Message = "Please select valid Idt type" });
                            }
                        }
                        else if (stockOut.stockOut.IsICT)
                        {
                            if (IdtMaster.IdtIctType != "ICT")
                            {
                                return Json(new { Message = "Please select valid Idt type" });
                            }
                        }
                        if (stockOut.stockOut.StockType != "LUT")
                        {

                            var isDepot = IdtDetails.Find(t => t.depotId == stockOut.stockOut.DepotId);
                            if (isProduct == null || isDepot == null)
                            {
                                return Json(new { Message = "Please select valid depot and product" });
                            }
                        }
                        else
                        {
                            var isUnit = IdtDetails.Find(t => t.unitId == stockOut.stockOut.UnitId);
                            if (isProduct == null || isUnit == null)
                            {
                                return Json(new { Message = "Please select valid unit and product" });
                            }
                        }


                        // FindCurrentIdtDetails
                        var depotId = stockOut.stockOut.DepotId == null ? 0 : stockOut.stockOut.DepotId;
                        var productId = stockOut.stockOut.ProductId;
                        var unitId = stockOut.stockOut.UnitId;
                        var currentIdtDetails = IdtDetails.Find(t => t.depotId == depotId && t.productId == productId && t.unitId == unitId);
                        if (stockOut.stockOut.Quantity > Convert.ToInt32(currentIdtDetails.AvailableQuantity))
                        {
                            return Json(new { Message = "Quantity Not available" });
                        }

                        var NewAvailableQuantity = Convert.ToInt32(currentIdtDetails.AvailableQuantity) - stockOut.stockOut.Quantity;
                        var ModifiedOn = DateTime.Now;
                        var Id = currentIdtDetails.Id;
                        IdtMasterId = IdtMaster.Id;
                        //var Status = "InProgress";
                        //if(NewAvailableQuantity == 0){
                        //    Status = "Completed";
                        //}
                        //else
                        //{
                        //    Status = "InProgress";
                        //}
                        string update = @"UPDATE IdtIctOutDetails SET AvailableQuantity=@NewAvailableQuantity,ModifiedOn=@ModifiedOn where  Id = @Id";
                        // string updateMaster = @"UPDATE IdtIctOutMaster SET Status=@Status WHERE Id = @Id";

                        var results = connection.Execute(update, new
                        {
                            NewAvailableQuantity,
                            ModifiedOn,
                            Id
                        });

                        //var results2 = connection.Execute(updateMaster, new
                        //{
                        //    Status,
                        //    Id

                        //});


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
                                IsAWS = stockOut.stockOut.IsAWS,
                                IsICT = stockOut.stockOut.IsICT,
                                IsIDT = stockOut.stockOut.IsIDT,
                                DepotId = stockOut.stockOut.DepotId,
                                UnitId = stockOut.stockOut.UnitId,
                                IdtReferenceId = IdtMasterId,

                            };
                            var result = connection.Execute(updateQuery, new
                            {
                                availableQuantity,
                                item.BID,

                            });
                            p.StockOutId = connection.Query<int>(@"insert StockOutMaster(Remarks,DateOfDispatch,BatchId,Quantity,ProductId,VoucherNumber,StockType,IsAWS,IsICT,IsIDT,DepotId,UnitId,IdtReferenceId) values (@Remarks,@DateOfDispatch,@BatchId,@Quantity,@ProductId,@VoucherNumber,@StockType,@IsAWS,@IsICT,@IsIDT,@DepotId,@UnitId,@IdtReferenceId) select cast(scope_identity() as int)", p).First();




                        }
                        scope.Complete();
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
                StockInList = connection.Query<Stock>("Select * from StockMaster").OrderBy(t => t.AddedOn).ToList();
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
                    var currentProduct = connection.Query<ProductListNew>("Select * from ProductMaster_New where Id = @value", new { value = item.ProductId }).FirstOrDefault();
                    viewStockInDetails.ProductName = currentProduct.VarietyName;

                    var currentCategory = connection.Query<CategoryType>("Select * from CategoryType where ID = @value", new { value = currentProduct.CatTypeId }).FirstOrDefault();
                    viewStockInDetails.CategoryName = currentCategory.Type;
                    viewStockInDetails.LotBatchId = item.BatchIdFromMobile;
                    viewStockInDetails.ProductId = item.ProductId;
                    viewStockInDetails.Description = item.Remarks;
                    viewStockInDetails.DateOfReceipt = item.RecievedOn;
                    viewStockInDetails.CRVNo = item.CRVNo;
                    viewStockInDetails.Quantity = item.Quantity;
                    viewStockInDetails.AccountingUnit = currentProduct.Unit;
                    viewStockInDetails.OrignalManufacture = item.OriginalManf;
                    viewStockInDetails.packaging = item.PackingMaterial;
                    viewStockInDetails.supplier = item.SupplierNo;
                    viewStockInDetails.weight = item.Weight;
                    viewStockInDetails.Remarks = item.Remarks;

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
                    var currentProduct = connection.Query<ProductListNew>("Select * from ProductMaster_New where Id = @value", new { value = item.ProductId }).FirstOrDefault();
                    viewStockOutDetails.ProductName = currentProduct.VarietyName;
                    var currentCategory = connection.Query<CategoryType>("Select * from CategoryType where ID = @value", new { value = currentProduct.CatTypeId }).FirstOrDefault();
                    viewStockOutDetails.CategoryName = currentCategory.Type;
                    // viewStockOutDetails.BatchId = item.BatchId;
                    viewStockOutDetails.BatchName = currentBatchDetails.BatchName;
                    viewStockOutDetails.ProductId = item.ProductId;
                    viewStockOutDetails.Remarks = item.Remarks;
                    viewStockOutDetails.Quantity = item.Quantity;
                    viewStockOutDetails.DateofDispatch = item.DateofDispatch;
                    viewStockOutDetails.StockType = item.StockType;
                    viewStockOutDetails.VoucherNumber = item.VoucherNumber;
                    viewStockOutDetails.AccountingUnit = currentProduct.Unit;
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
                List<int> productIds = new List<int>();
                foreach (var item in StockInList)
                {
                    AvailableStock viewStockInDetails = new AvailableStock();
                    string[] BatchId = item.BatchIdFromMobile.Split(',');
                    if (!productIds.Contains(item.ProductId))
                    {
                        productIds.Add(item.ProductId);

                        var currentProduct = connection.Query<ProductListNew>("Select * from ProductMaster_New where Id = @value", new { value = item.ProductId }).FirstOrDefault();
                        viewStockInDetails.ProductName = currentProduct.VarietyName;
                        viewStockInDetails.unit = currentProduct.Unit;
                        var currentCategory = connection.Query<CategoryType>("Select * from CategoryType where ID = @value", new { value = currentProduct.CatTypeId }).FirstOrDefault();
                        viewStockInDetails.CategoryName = currentCategory.Type;
                        viewStockInDetails.LotBatchId = item.BatchIdFromMobile;
                        viewStockInDetails.ProductId = item.ProductId;
                        viewStockInDetails.Description = item.Remarks;
                        viewStockInDetails.DateOfReceipt = item.RecievedOn;
                        int availableQUantity = 0;
                        string sheds = "";
                        foreach (var batchIds in BatchId)
                        {
                           
                            viewStockInDetails.Batch = new List<BatchDetails>();
                            
                            var currentBatchDetails = connection.Query<BatchDetails>("Select * from BatchMaster where BID = @value", new { value = batchIds }).FirstOrDefault();
                            BatchDetails tempBatchDetails = new BatchDetails();
                            tempBatchDetails.BID = currentBatchDetails.BID;
                            tempBatchDetails.BatchName = currentBatchDetails.BatchName;
                            tempBatchDetails.Esl = currentBatchDetails.Esl;
                            tempBatchDetails.AvailableQuantity = currentBatchDetails.AvailableQuantity;
                            availableQUantity = currentBatchDetails.AvailableQuantity + availableQUantity;
                            tempBatchDetails.WarehouseID = currentBatchDetails.WarehouseID;
                            tempBatchDetails.EXPDate = currentBatchDetails.EXPDate;
                            tempBatchDetails.WarehouseNo = currentBatchDetails.WarehouseNo;
                            sheds = sheds + tempBatchDetails.WarehouseNo+",";

                            viewStockInDetails.Batch.Add(tempBatchDetails);
                        }
                        viewStockInDetails.TotalAvailableQuantity = availableQUantity;
                        viewStockInDetails.Sheds=sheds.TrimEnd(',');
                        viewStockIns.Add(viewStockInDetails);

                    }

                    else
                    {
                        foreach (var batchIds in BatchId)
                        {
                            
                            viewStockInDetails.Batch = new List<BatchDetails>();

                            var currentBatchDetails = connection.Query<BatchDetails>("Select * from BatchMaster where BID = @value", new { value = batchIds }).FirstOrDefault();
                            Warehouse warehouse = connection.Query<Warehouse>("Select * from tblWarehouse where ID = @ID", new { ID = currentBatchDetails.WarehouseID }).FirstOrDefault();

                            BatchDetails tempBatchDetails = new BatchDetails();
                            int availableQUantity = 0;
                            string sheds = "";
                            tempBatchDetails.BID = currentBatchDetails.BID;
                            tempBatchDetails.BatchName = currentBatchDetails.BatchName;
                            tempBatchDetails.Esl = currentBatchDetails.Esl;
                            tempBatchDetails.AvailableQuantity = currentBatchDetails.AvailableQuantity;
                            tempBatchDetails.WarehouseID = currentBatchDetails.WarehouseID;
                            tempBatchDetails.EXPDate = currentBatchDetails.EXPDate;
                            tempBatchDetails.WarehouseNo = warehouse.WareHouseNo;
                            tempBatchDetails.Esl = currentBatchDetails.Esl;
                            tempBatchDetails.MFGDate = currentBatchDetails.MFGDate;
                            tempBatchDetails.WeightUnit = currentBatchDetails.WeightUnit;
                            sheds = sheds + tempBatchDetails.WarehouseNo + ",";
                            availableQUantity = currentBatchDetails.AvailableQuantity + availableQUantity;
                            // viewStockInDetails.Batch.Add(tempBatchDetails);
                            var result = viewStockIns.Find(x => x.ProductId == item.ProductId);
                            result.TotalAvailableQuantity = result.TotalAvailableQuantity + availableQUantity;
                            result.Sheds = result.Sheds + sheds;
                            result.Batch.Add(tempBatchDetails);
                            
                        }
                        


                    }
                   
                    //viewStockIns.Add(viewStockInDetails);

                }
                connection.Close();
            }
            return viewStockIns;

        }

        public async Task<IHttpActionResult> AddStockList([FromBody] List<StockIn> stockInList)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();
                foreach (var stockIn in stockInList)
                {

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
                            BatchNo = item.BatchNo,
                            SectionID = item.SectionID



                        };
                        quantity = quantity + item.Quantity;
                        batchDetails.BatchId = connection.Query<int>(@"insert BatchMaster(BatchName,Quantity,WarehouseID,MFGDate,EXPDate,ESL,AvailableQuantity,BatchCode,BatchNo,SectionID) values (@BatchName,@Quantity,@WarehouseID,@MFGDate,@EXPDate,@ESL,@AvailableQuantity,@BatchCode,@BatchNo,@SectionID) select cast(scope_identity() as int)", batchDetails).First();
                        BatchIds.Add(batchDetails.BatchId);
                    }


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
                        DepotId = stockIn.stock.DepotId,
                        IsCP = stockIn.stock.IsCP,
                        IsLP = stockIn.stock.IsLP,
                        IsIDT = stockIn.stock.IsIDT,
                        IsICT = stockIn.stock.IsICT,


                    };

                    stockInDetails.StockInId = connection.Query<int>(@"insert StockMaster(BatchIdFromMobile,RecievedOn,CRVNo,Remarks,RecievedFrom,
                                         PackingMaterial,OriginalManf,GenericName,Weight,AddedOn,SupplierId,ProductId,Quantity,IsFromMobile,ATNo,OtherSupplier,TransferedBy,SampleSent,SupplierNo,DepotId,IsCP,IsLP,IsIDT,IsICT
) values (@BatchIdFromMobile,@RecievedOn,@CRVNo,@Remarks,@RecievedFrom,
                                         @PackingMaterial,@OriginalManf,@GenericName,@Weight,@AddedOn,@SupplierId,@ProductId,@Quantity,@IsFromMobile,@ATNo,@OtherSupplier,@TransferedBy,@SampleSent,@SupplierNo,@DepotId,@IsCP,@IsLP,@IsIDT,@IsICT) select cast(scope_identity() as int)", stockInDetails).First();



                }
                return Json(new { Message = "Record Inserted Successfully" });





            }
        }
        [HttpPost]
        public async Task<IHttpActionResult> UpdateIdtOut(string referenceNUmber)
        {
            using (var connection = new SqlConnection(sqlConnectionString))
            {
                var IdtMaster = connection.Query<firstForm>("Select * from IdtIctOutMaster where ReferenceNumber = @referenceNUmber", new { ReferenceNumber = referenceNUmber }).FirstOrDefault();
                var IdtDetails = connection.Query<depotProductValueModel>("Select * from IdtIctOutDetails where IdtIctOutMasterId=@IdtIctMasterId", new { IdtIctMasterId = IdtMaster.Id }).ToList();
                var findIsAvailable = IdtDetails.FindAll(t => t.AvailableQuantity != "0").ToList();
                if (findIsAvailable.Count == 0)
                {

                    var Status = "Completed";

                    var referenceNumber = referenceNUmber;
                    string updateMaster = @"UPDATE IdtIctOutMaster SET Status=@Status WHERE ReferenceNumber = @referenceNumber";
                    var results2 = connection.Execute(updateMaster, new
                    {
                        Status,


                    });

                }
                return Json(new { Message = "Record Updated Successfully" });
            }
        }
        [HttpPost]
        public async Task<IHttpActionResult> UpdateIdtIn(string referenceNUmber)
        {
            using (var connection = new SqlConnection(sqlConnectionString))
            {
                var IdtMaster = connection.Query<firstForm>("Select * from IdtIctMaster where ReferenceNumber = @referenceNUmber", new { ReferenceNumber = referenceNUmber }).FirstOrDefault();
                var IdtDetails = connection.Query<depotProductValueModel>("Select * from IdtIctDetails where IdtIctMasterId=@IdtIctMasterId", new { IdtIctMasterId = IdtMaster.Id }).ToList();
                var findIsAvailable = IdtDetails.FindAll(t => t.AvailableQuantity != "0").ToList();
                if (findIsAvailable.Count == 0)
                {

                    var Status = "Completed";

                    var referenceNumber = referenceNUmber;
                    string updateMaster = @"UPDATE IdtIctDetails SET Status=@Status WHERE ReferenceNumber = @referenceNumber";
                    var results2 = connection.Execute(updateMaster, new
                    {
                        Status,


                    });

                }
                return Json(new { Message = "Record Updated Successfully" });
            }
        }


        [HttpGet]
        public AvailableStockForDashboard GetWarehouseStock(int ID)
        {
            AvailableStockForDashboard availableStockForDashboards = new AvailableStockForDashboard();
            availableStockForDashboards.WarehouseId = ID;
            availableStockForDashboards.availabeProductForDashboards = new List<AvailabeProductForDashboard>();


            List<BatchDetails> batch = new List<BatchDetails>();
            List<int> productIds = new List<int>();
            using (var connection = new SqlConnection(sqlConnectionString))
            {

                connection.Open();
                Warehouse warehouse = connection.Query<Warehouse>("Select * from tblWarehouse where ID = @ID", new { ID = ID }).FirstOrDefault();
                batch = connection.Query<BatchDetails>("Select * from BatchMaster where WarehouseID = @ID", new { ID = ID }).ToList();
                foreach (var item in batch)
                {
                    var stockList = connection.Query<Stock>("Select * from StockMaster where BatchIdFromMobile = @ID", new { ID = item.BID }).ToList();
                    var availableQuantity = 0;

                    foreach (var stockItme in stockList)
                    {
                        AvailabeProductForDashboard availabeProductForDashboards = new AvailabeProductForDashboard();

                        var currentProduct = connection.Query<ProductListNew>("Select * from ProductMaster_New where Id = @value", new { value = stockItme.ProductId }).FirstOrDefault();
                        var currentCatType = connection.Query<CategoryType>("Select * from CategoryType where ID = @value", new { value = currentProduct.CatTypeId }).FirstOrDefault();
                        var currentCat = connection.Query<Category>("Select * from CategoryMaster where ID = @value", new { value = currentCatType.Category_ID }).FirstOrDefault();
                        availabeProductForDashboards.Quantity = availableQuantity + item.AvailableQuantity;
                        if (!productIds.Contains(stockItme.ProductId))
                        {
                            //IsAvailable Region
                            var currentProdId = stockItme.ProductId;
                            var productStockList = connection.Query<Stock>("Select * from StockMaster where ProductId = @ID", new { ID = stockItme.ProductId }).ToList();
                            for (int i = 0; i < productStockList.Count; i++)
                            {
                                var AllBatchDetails = connection.Query<BatchDetails>("Select * from BatchMaster where BID = @ID", new { ID = productStockList[i].BatchIdFromMobile }).ToList();
                                string warehouseName = "";
                                for (int j = 0; i < AllBatchDetails.Count; i++)
                                {
                                    if (AllBatchDetails[j].AvailableQuantity > 0 && AllBatchDetails[j].WarehouseID != ID)
                                    {
                                        var warehouseDetails = connection.Query<Warehouse>("Select * from tblWarehouse where ID = @ID", new { ID = AllBatchDetails[j].WarehouseID }).FirstOrDefault();
                                        warehouseName = warehouseName + warehouseDetails.WareHouseNo;
                                        availabeProductForDashboards.IsAvailableinOther = true;
                                        availabeProductForDashboards.OtherShedList = warehouseName;
                                    }
                                    else
                                    {
                                        availabeProductForDashboards.IsAvailableinOther = false;
                                    }
                                }
                            }




                            availabeProductForDashboards.Batch = batch;
                            productIds.Add(stockItme.ProductId);
                            availabeProductForDashboards.CategoryName = currentCat.Category_Name;
                            availabeProductForDashboards.ProductId = stockItme.ProductId;
                            availabeProductForDashboards.ProductName = currentProduct.VarietyName;
                            availabeProductForDashboards.Unit = currentProduct.Unit;


                            availableStockForDashboards.availabeProductForDashboards.Add(availabeProductForDashboards);
                        }
                        //var OtherStockList = connection.Query<Stock>("Select * from StockMaster where ProductId = @ID", new { ID = item.PID }).ToList();




                    }
                }

                connection.Close();
            }
            return availableStockForDashboards;

        }
    }
}

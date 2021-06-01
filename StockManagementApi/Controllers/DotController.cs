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
    public class DotController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        [HttpPost]
        public async Task<IHttpActionResult> AddDot([FromBody]DotModel value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CommandExist = connection.Query<DotModel>("Select * from DotMaster where DotName = @Name", new { Name = value.DotName }).FirstOrDefault();
                if (CommandExist == null)
                {
                    var p = new DotModel
                    {
                        DotName = value.DotName,
                        AccountingUnit = value.AccountingUnit,
                        Dot = value.Dot,
                        GSReserve = value.GSReserve,
                        IsActive = true

                    };
                    
                    
                    p.Id = connection.Query<int>(@"insert DotMaster(DotName,AccountingUnit,Dot,GSReserve,IsActive) values (@DotName,@AccountingUnit,@Dot,@GSReserve,@IsActive) select cast(scope_identity() as int)", p).First();
                    for (int i = 0; i < value.ProductListNew.Count; i++)
                    {
                        var product = new DotProductMaster
                        {
                            DotId = p.Id,
                            ProductId = value.ProductListNew[i].ProductId
                        };
                        product.DotProductId = connection.Query<int>(@"insert DotProductMaster(DotId,ProductId) values (@DotId,@ProductId) select cast(scope_identity() as int)", product).First();
                    }
                    

                    return Json(new { Message = "Record Inserted Successfully" });


                }
                else
                {
                    throw new ProcessException("Dot already exists");
                }


            }
        }

        [HttpPut]
        public async Task<IHttpActionResult> DeleteDot([FromBody]Object Id)
        {
            var categoryId = Convert.ToInt32(Id);
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CategoryExist = connection.Query<DotModel>("Select * from DotMaster where Id = @Id", new { Id = categoryId }).FirstOrDefault();
                if (CategoryExist == null)
                {
                    throw new ProcessException("Selected Dot not exists");
                }
                else
                {
                    string updateQuery = @"UPDATE Dot Set IsActivated = @IsActive where Id = @Id";
                    var result = connection.Execute(updateQuery, new { IsActive = false, Id = categoryId });

                    return Json(new { Message = "Record deleted successfully!" });
                }


            }
        }
        [HttpGet]
        public dynamic GetAllDot()
        {
            
            var connection = new SqlConnection(sqlConnectionString);
            var dotList = connection.Query<DotModel>("Select * from DotMaster where IsActive = 1").ToList();
            List<DotModel> responseModel = new List<DotModel>();
            
            for (int i = 0; i <dotList.Count; i++)
            {
                DotModel temp = new DotModel();
                temp.DotName = dotList[i].DotName;
                temp.Dot = dotList[i].Dot;
                temp.AccountingUnit = dotList[i].AccountingUnit;
                temp.GSReserve = dotList[i].GSReserve;
                temp.Id = dotList[i].Id;
                temp.ProductListNew = new List<DotProductMaster>();
                                var dotProductList = connection.Query<DotProductMaster>("Select * from DotProductMaster where DotId = '" + dotList[i].Id + "'").ToList();
                for (int j = 0; j < dotProductList.Count; j++)
                {
                    DotProductMaster productList = new DotProductMaster();
                    
                    
                    var ProductList = connection.Query<ProductListNew>("Select * from ProductMaster_New where Id = '" + dotProductList[j].ProductId + "'").First();
                    productList.ProductId = ProductList.Id;
                    productList.productName = ProductList.VarietyName;
                    temp.ProductListNew.Add(productList);
                }
                responseModel.Add(temp);
            }
            //SqlCommand command = new SqlCommand("spManageDot", connection);
            //command.CommandType = System.Data.CommandType.StoredProcedure;

            //connection.Open();

            //DataTable dt = new DataTable();

            //dt.Load(command.ExecuteReader());
            //var list = DataTableToJSONWithJSONNet(dt);
            //dynamic json = JsonConvert.DeserializeObject(list);


            return responseModel;

        }
       
        public string DataTableToJSONWithJSONNet(DataTable table)
        {
            string JSONString = string.Empty;
            JSONString = JsonConvert.SerializeObject(table);
            return JSONString;
        }

        public dynamic GetByDotId(int Id)
        {
            var supplier = new DotModel();
            var connection = new SqlConnection(sqlConnectionString);
            supplier = connection.Query<DotModel>("Select * from DotMaster where Id = @Id", new { Id = Id }).FirstOrDefault();
            return supplier;
        }

        [HttpPost]
        public async Task<IHttpActionResult> UpdateDot([FromBody]DotModel value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var p = new DotModel
                {
                    DotName = value.DotName,
                    AccountingUnit = value.AccountingUnit,
                    Dot = value.Dot,
                    GSReserve = value.GSReserve,


                };

                string updateQuery = @"UPDATE DotMaster SET Dot = @Dot,Name=@Name,AccountingUnit = @AccountingUnit,GSReserve=@GSReserve, Name= @Name WHERE Id = @Id";

                var result = connection.Execute(updateQuery, value);
                scope.Complete();
                return Json(new { Message = "Record Updated Successfully" });
            }
        }
    }
}

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
    public class WarehouseController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];

        [HttpPost]
        public async Task<IHttpActionResult> AddWarehouse([FromBody]Warehouse value)
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

                    var WareHouseExist = connection.Query<Warehouse>("Select * from tblwarehouse where WareHouseNo = @WareHouseNo", new { WareHouseNo = value.WareHouseNo }).FirstOrDefault();
                    if (WareHouseExist == null)
                    {
                        var p = new Warehouse
                        {

                            WareHouseNo = value.WareHouseNo,
                            Description = value.Description,
                            IsActive = true,
                            Addedon = DateTime.Now,
                            ModifiedOn = DateTime.Now

                        };
                        p.ID = connection.Query<int>(@"insert tblwarehouse(WareHouseNo,Description,IsActive,Addedon,ModifiedOn) values (@WareHouseNo,@Description,@IsActive,@Addedon,@ModifiedOn) select cast(scope_identity() as int)", p).First();
                        scope.Complete();
                        return Json(new { Message = "Record Inserted Successfully" });


                    }
                    else
                    {
                        throw new ProcessException("Warehouse already exists");
                    }


                }
                catch (Exception)
                {

                    throw;
                }
            }
        }

        [HttpGet]
        public async Task<IHttpActionResult> GetWarehouseList()
        {
            List<Warehouse> warehouseNoList = new List<Warehouse>();
            var connection = new SqlConnection(sqlConnectionString);
            warehouseNoList = connection.Query<Warehouse>("Select * from tblWarehouse").ToList();
            List<WareHouseList> warehouseList = new List<WareHouseList>();
            for (int i = 0; i < warehouseNoList.Count; i++)
            {
                WareHouseList tempwarehouseList = new WareHouseList();
                var ID = warehouseNoList[i].ID;
                var warehouseSection = connection.Query<WarehouseSection>("Select * from tblSection where WarehouseID = @ID", new { Id = ID }).ToList();
                for (int j = 0; j < warehouseSection.Count; j++)
                {
                    tempwarehouseList.WarehouseId = ID;
                    tempwarehouseList.WarehouseSection = warehouseSection[j].Section;
                    tempwarehouseList.WareHouseNo = warehouseNoList[i].WareHouseNo;
                    tempwarehouseList.SectionId = warehouseSection[j].ID;
                    warehouseList.Add(tempwarehouseList);


                    DataTable dt = new DataTable();

                    // dt.Load(command.ExecuteReader());
                    //  var list = DataTableToJSONWithJSONNet(dt);
                    //dynamic json = JsonConvert.DeserializeObject(warehouseList);
                    // data.UnitList = json;
                }

            }
            WareHouseData wareHouseData = new WareHouseData();
            wareHouseData.WareHouseLists = warehouseList;
            return Ok(wareHouseData);
        }


        [HttpGet]
        public async Task<IHttpActionResult> GetWarehouseListForWeb()
        {
            List<Warehouse> warehouseNoList = new List<Warehouse>();
            var connection = new SqlConnection(sqlConnectionString);
            warehouseNoList = connection.Query<Warehouse>("Select * from tblWarehouse").ToList();
            return Ok(warehouseNoList);
        }
        public dynamic GetByWarehouseId(int Id)
        {
            var warehouse = new Warehouse();
            var connection = new SqlConnection(sqlConnectionString);
            warehouse = connection.Query<Warehouse>("Select * from tblWarehouse where ID = @Id", new { Id = Id }).FirstOrDefault();
            return warehouse;
        }
        [HttpPost]
        public async Task<IHttpActionResult> UpdateWarhouse([FromBody]Warehouse value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var warehouse = new Warehouse()
                {
                    WareHouseNo = value.WareHouseNo,
                    Description = value.Description,
                    IsActive = true,
                    ModifiedBy = 0,
                    ModifiedOn = DateTime.Now,
                    ID = value.ID
                };

                string updateQuery = @"UPDATE tblWarehouse SET WareHouseNo = @WareHouseNo,Description=@Description, IsActive= @IsActive, ModifiedBy= @ModifiedBy, ModifiedOn= @ModifiedOn WHERE ID = @ID";

                var result = connection.Execute(updateQuery, warehouse);
                scope.Complete();
                return Json(new { Message = "Record Updated Successfully" });
            }
        }

        public dynamic GetAllWarehouseSection()
        {

            var connection = new SqlConnection(sqlConnectionString);
            SqlCommand command = new SqlCommand("spManageWarehouseSection", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            connection.Open();

            DataTable dt = new DataTable();

            dt.Load(command.ExecuteReader());
            var list = DataTableToJSONWithJSONNet(dt);
            dynamic json = JsonConvert.DeserializeObject(list);


            return json;
        }
        public string DataTableToJSONWithJSONNet(DataTable table)
        {
            string JSONString = string.Empty;
            JSONString = JsonConvert.SerializeObject(table);
            return JSONString;
        }

        [HttpPost]
        public async Task<IHttpActionResult> AddWarehouseSection([FromBody]WarehouseSection warehouseSection)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            using (var connection = new SqlConnection(sqlConnectionString))
            {
                connection.Open();

                var p = new WarehouseSection
                {
                    WarehouseID = warehouseSection.ID,
                    Row = warehouseSection.Row,
                    Addedon = DateTime.Now,
                    Section = warehouseSection.Section,
                    SubSection = warehouseSection.SubSection,
                    Col = warehouseSection.Col,
                    Drawers=warehouseSection.Drawers
                };
                p.ID = connection.Query<int>(@"insert tblSection(WarehouseID,Row,Addedon,Section,SubSection,Col,Drawers) values (@WarehouseID,@Row,@Addedon,@Section,@SubSection,@Col,@Drawers) select cast(scope_identity() as int)", p).First();

                return Json(new { Message = "Record Inserted Successfully" });

            }


        }
        public dynamic GetByWarehouseSectionId(int Id)
        {
            var warehouseSection = new WarehouseSection();
            var connection = new SqlConnection(sqlConnectionString);
            warehouseSection = connection.Query<WarehouseSection>("Select * from tblSection where ID = @Id", new { Id = Id }).FirstOrDefault();
            return warehouseSection;
        }
        [HttpPost]
        public async Task<IHttpActionResult> UpdateWarehouseSection([FromBody]WarehouseSection value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var categoryType = new WarehouseSection()
                {
                    WarehouseID = value.WarehouseID,
                    Section = value.Section,
                    SubSection = value.SubSection,
                    Row = value.Row,
                    Col = value.Col,
                    Drawers = value.Drawers,
                    ID = value.ID
                };

                string updateQuery = @"UPDATE tblSection SET WarehouseID = @WarehouseID,Section=@Section,SubSection = @SubSection, Row= @Row, Col= @Col, Drawers= @Drawers WHERE ID = @ID";

                var result = connection.Execute(updateQuery, categoryType);
                scope.Complete();
                return Json(new { Message = "Record Updated Successfully" });
            }
        }

    }

}

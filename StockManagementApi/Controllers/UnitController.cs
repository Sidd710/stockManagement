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
    public class UnitController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        [HttpPost]
        public async Task<IHttpActionResult> AddUnit([FromBody]UnitList value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CommandExist = connection.Query<UnitList>("Select * from UnitMaster where Unit_Name = @Unit_Name", new { Unit_Name = value.Unit_Name }).FirstOrDefault();
                if (CommandExist == null)
                {
                    var p = new UnitList
                    {
                        Unit_Name = value.Unit_Name,
                        Depu_Id= value.Depu_Id,
                        Unit_Desc = value.Unit_Desc,                        
                        IsActive = true,
                        Addedon = DateTime.Now,
                        ModifiedOn = DateTime.Now,
                        Command = 0,
                        Formation = 0,
                        UnitType=value.UnitType,
                        UnitTypeOther=value.UnitTypeOther
                    };
                    p.Unit_Id = connection.Query<int>(@"insert UnitMaster(Unit_Name,Depu_Id,Unit_Desc,IsActive,Addedon,ModifiedOn,Command,Formation,UnitType,UnitTypeOther) values (@Unit_Name,@Depu_Id,@Unit_Desc,@IsActive,@Addedon,@ModifiedOn,@Command,@Formation,@UnitType,@UnitTypeOther) select cast(scope_identity() as int)", p).First();

                    return Json(new { Message = "Record Inserted Successfully" });


                }
                else
                {
                    throw new ProcessException("Formation already exists");
                }


            }
        }
        public UnitListData GetAllUnit()
        {
            UnitListData data = new UnitListData();

            var connection = new SqlConnection(sqlConnectionString);
            SqlCommand command = new SqlCommand("spManageUnit", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            connection.Open();

            DataTable dt = new DataTable();

            dt.Load(command.ExecuteReader());
            var list = DataTableToJSONWithJSONNet(dt);
            dynamic json = JsonConvert.DeserializeObject(list);
            data.UnitList = json;

            return data;

        }

        public dynamic GetAllUnitType()
        {
            var connection = new SqlConnection(sqlConnectionString);
            SqlCommand command = new SqlCommand("spManageUnitType", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            connection.Open();

            DataTable dt = new DataTable();

            dt.Load(command.ExecuteReader());
            var list = DataTableToJSONWithJSONNet(dt);
            dynamic json = JsonConvert.DeserializeObject(list);


            return json;
        }

        [HttpPut]
        public async Task<IHttpActionResult> DeleteUnit([FromBody]Object Id)
        {
            var unitId = Convert.ToInt32(Id);
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CommandExist = connection.Query<FormationList>("Select * from UnitMaster where Unit_Id = @Id", new { Id = unitId }).FirstOrDefault();
                if (CommandExist == null)
                {
                    throw new ProcessException("Selected unit not exists");
                }
                else
                {
                    string updateQuery = @"UPDATE UnitMaster Set IsActive = @IsActive where Unit_Id = @Id";
                    var result = connection.Execute(updateQuery, new { IsActive = false, Id = unitId });

                    return Json(new { Message = "Record deleted successfully!" });
                }


            }
        }

        private string DataTableToJSONWithJSONNet(DataTable table)
        {
            string JSONString = string.Empty;
            JSONString = JsonConvert.SerializeObject(table);
            return JSONString;
        }

        public dynamic GetByUnitId(int Id)
        {
            var unit = new UnitList();
            var connection = new SqlConnection(sqlConnectionString);
            unit = connection.Query<UnitList>("Select * from UnitMaster where Unit_Id = @Id", new { Id = Id }).FirstOrDefault();
            return unit;
        }

        [HttpPost]
        public async Task<IHttpActionResult> UpdateUnit([FromBody]UnitList value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();


                var Unit_Name = value.Unit_Name;
                var Depu_Id = value.Depu_Id;
                var Unit_Desc = value.Unit_Desc;                
                var ModifiedOn = DateTime.Now;
                var UnitType = value.UnitType;
                var UnitTypeOther = value.UnitTypeOther;
                var Unit_Id = value.Unit_Id;


                string updateQuery = @"UPDATE UnitMaster SET Unit_Name = @Unit_Name,Depu_Id=@Depu_Id,Unit_Desc=@Unit_Desc,ModifiedOn=@ModifiedOn,UnitType=@UnitType,UnitTypeOther=@UnitTypeOther WHERE Unit_Id = @Unit_Id";

                var result = connection.Execute(updateQuery, new
                {
                    Unit_Name,
                    Depu_Id,
                    Unit_Desc,
                    ModifiedOn,
                    UnitType,
                    UnitTypeOther
                });
                scope.Complete();
                return Json(new { Message = "Record Updated Successfully" });
            }
        }

    }
}

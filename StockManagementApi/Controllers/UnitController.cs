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
        public string DataTableToJSONWithJSONNet(DataTable table)
        {
            string JSONString = string.Empty;
            JSONString = JsonConvert.SerializeObject(table);
            return JSONString;
        }

    }
}

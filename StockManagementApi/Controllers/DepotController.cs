﻿using Dapper;
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
    public class DepotController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        [HttpPost]
        public async Task<IHttpActionResult> AddDepot([FromBody]DepotList value)

        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CommandExist = connection.Query<DepotList>("Select * from depumaster where Depu_Name = @Depu_Name", new { Depu_Name = value.Depu_Name }).FirstOrDefault();
                if (CommandExist == null)
                {
                    var p = new DepotList
                    {
                        Depu_Name = value.Depu_Name,
                        Corp = value.Corp,
                        FormationId = value.FormationId,
                        IsActive = true,
                        Addedon = DateTime.Now,
                        ModifiedOn = DateTime.Now,
                        IsParent = value.IsParent,
                        Depu_Location = value.Depu_Location,
                        Depot_Code = value.Depot_Code  ,
                        UnitName = value.UnitName
                    };
                    p.Depu_Id = connection.Query<int>(@"insert depumaster(Depu_Name,Corp,FormationId,IsActive,Addedon,ModifiedOn,IsParent,Depu_Location,Depot_Code,UnitName) values (@Depu_Name,@Corp,@FormationId,@IsActive,@Addedon,@ModifiedOn,@IsParent,@Depu_Location,@Depot_Code,@UnitName) select cast(scope_identity() as int)", p).First();

                    return Json(new { Message = "Record Inserted Successfully" });


                }
                else
                {
                    throw new ProcessException("Depot already exists");
                }


            }
        }
        public dynamic GetAllDepot()
        {               
            var connection = new SqlConnection(sqlConnectionString);
            SqlCommand command = new SqlCommand("spManageDepot", connection);
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

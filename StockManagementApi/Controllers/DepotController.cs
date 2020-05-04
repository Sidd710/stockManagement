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
                        Depot_Code = value.Depot_Code,
                        UnitName = value.UnitName,
                        IDT = value.IDT_bool == true ? "IDT" : null,
                        ICT = value.ICT_bool == true ? "ICT" : null,    
                        AWS = value.AWS_bool == true ? "AWS" : null,
                        IsMother=value.IsMother
                    };
                    p.Depu_Id = connection.Query<int>(@"insert depumaster(Depu_Name,Corp,FormationId,IsActive,Addedon,ModifiedOn,IsParent,Depu_Location,Depot_Code,UnitName,IDT,ICT,AWS,IsMother) values (@Depu_Name,@Corp,@FormationId,@IsActive,@Addedon,@ModifiedOn,@IsParent,@Depu_Location,@Depot_Code,@UnitName,@IDT,@ICT,@AWS,@IsMother) select cast(scope_identity() as int)", p).First();

                    return Json(new { Message = "Record Inserted Successfully" });


                }
                else
                {
                    throw new ProcessException("Depot already exists");
                }


            }
        }
        public DepotListData GetAllDepot()
        {
            DepotListData depotListData = new DepotListData();
            var connection = new SqlConnection(sqlConnectionString);
            SqlCommand command = new SqlCommand("spManageDepot", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            connection.Open();

            DataTable dt = new DataTable();

            dt.Load(command.ExecuteReader());
            var list = DataTableToJSONWithJSONNet(dt);
            dynamic json = JsonConvert.DeserializeObject(list);

            depotListData.DepotList=json;
            return depotListData;

        }

        [HttpPut]
        public async Task<IHttpActionResult> DeleteDepot([FromBody]Object Id)
        {
            var depotId = Convert.ToInt32(Id);
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CommandExist = connection.Query<FormationList>("Select * from depumaster where Depu_Id = @Id", new { Id = depotId }).FirstOrDefault();
                if (CommandExist == null)
                {
                    throw new ProcessException("Selected depot not exists");
                }
                else
                {
                    string updateQuery = @"UPDATE DepuMaster Set IsActive = @IsActive where Depu_Id = @Id";
                    var result = connection.Execute(updateQuery, new { IsActive = false, Id = depotId });

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
    }
}

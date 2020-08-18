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
                var homeDepot = connection.Query<DepotList>("select * from depumaster where IsParent = 1").FirstOrDefault();
                if(homeDepot != null && value.IsParent)
                {
                    return Json(new { Message = "Only one home depot can be added which is already exists!" });
                }
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
                        IsMother = value.IsMother
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

            depotListData.DepotList = json;
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

        public dynamic GetByDepotId(int Id)
        {
            var depot = new DepotList();
            var connection = new SqlConnection(sqlConnectionString);
            depot = connection.Query<DepotList>("Select * from DepuMaster where Depu_Id = @Id", new { Id = Id }).FirstOrDefault();
            if (depot.AWS != null && depot.AWS == "AWS")
            {
                depot.AWS_bool = true;
            }
            else if (depot.ICT != null && depot.ICT == "ICT")
            {
                depot.ICT_bool = true;
            }
            else if (depot.IDT != null && depot.IDT == "IDT")
            {
                depot.IDT_bool = true;
            }

            return depot;
        }

        [HttpPost]

        public async Task<IHttpActionResult> UpdateDepot([FromBody]DepotList value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();
                var homeDepot = connection.Query<DepotList>("select * from depumaster where IsParent = 1").FirstOrDefault();
                if (homeDepot.Depu_Id != value.Depu_Id && value.IsParent) {
                    return Json(new { Message = "Only one home depot can be added which is already exists!" });
                }
                var AWS = string.Empty;
                var ICT = string.Empty;
                var IDT = string.Empty;
                if (value.AWS_bool)
                {
                    AWS = "AWS";
                }
                else if (value.ICT_bool)
                {
                    ICT = "ICT";
                }
                else if (value.IDT_bool)
                {
                    IDT = "IDT";
                }
                var depot = new DepotList()
                {
                    Depu_Name = value.Depu_Name,
                    Depu_Location = value.Depu_Location,
                    AWS = AWS,
                    Corp = value.Corp,
                    FormationId = value.FormationId,
                    ICT = ICT,
                    IDT = IDT,
                    IsActive = value.IsActive,
                    IsMother = value.IsMother,
                    IsParent = value.IsParent,
                    ModifiedBy = 0,
                    ModifiedOn = DateTime.Now,
                    UnitName = value.UnitName,
                    Depu_Id = value.Depu_Id
                };




                string updateQuery = @"Update DepuMaster 
                                              Set 
                                                Depu_Name = @Depu_Name ,
                                                Depu_Location = @Depu_Location,
                                                AWS=@AWS,
                                                Corp=@Corp ,
                                                FormationId = @FormationId,
                                                ICT=@ICT,
                                                IDT = @IDT,
                                                IsActive=@IsActive,
                                                IsMother=@IsMother,
                                                IsParent=@IsParent,
                                                ModifiedBy=@ModifiedBy,
                                                ModifiedOn=@ModifiedOn,
                                                UnitName=@UnitName
                                              Where Depu_Id = @Depu_Id";

                var result = connection.Execute(updateQuery, depot);
                scope.Complete();
                return Json(new { Message = "Record Updated Successfully" });
            }
        }
    }
}

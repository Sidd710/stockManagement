using Dapper;
using StockManagementApi.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Web.Http;
using System.Web.Http.Description;
using System.Threading.Tasks;
using System.Configuration;

namespace StockManagementApi.Controllers
{
    public class UserController : ApiController
    {
        //   private string sqlConnectionString = @"Data Source = DESKTOP-M7VFT38\SQLEXPRESS;initial catalog=SAMRTHOct23;Integrated Security=True;";

        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        // POST: api/User
        [HttpPost]
        [ResponseType(typeof(UserMaster))]
        [Authorize(Roles = "17")]
        public async Task<IHttpActionResult> AddUser([FromBody]UserMaster value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var userExist = connection.Query<UserMaster>("Select * from UserMaster where User_Name like @value", new { value = value.User_name }).FirstOrDefault();
                if (userExist == null)
                {
                    //var p = new UserMaster { FirstName = value.FirstName, LastName = value.LastName, User_Name = value.User_Name, RoleId = value.RoleId, Password = value.Password, IsActive = value.IsActive };
                    //p.UserId = connection.Query<int>(@"insert Stock_UserMaster(FirstName,LastName,User_Name,RoleId,Password,IsActive) values (@FirstName,@LastName,@User_Name,@RoleId,@Password,@IsActive) select cast(scope_identity() as int)", p).First();
                    await InsertAsync(value, connection,"Insert");
                    return Json(new { Message = "Record Inserted Successfully" });
                    

                }
                else
                {
                    throw new ProcessException("Username already exists");
                }


            }

        }
        public class ProcessException : Exception
        {
            public ProcessException(string message)
                : base(message)
            {

            }
        }
        [HttpPut]
        [ResponseType(typeof(UserMaster))]
        [Authorize(Roles = "17")]
        public async Task<IHttpActionResult> UpdateUser([FromBody]UserMaster value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var userExist = connection.Query<UserMaster>("Select * from UserMaster where User_Id = @value", new { value = value.User_Id }).FirstOrDefault();
                if (userExist != null)
                {

                    var recordExist = connection.Query<UserMaster>("Select * from UserMaster where User_Id != @value and User_name =@value1 ", new { value = value.User_Id, value1 = value.User_name }).FirstOrDefault();
                    if (recordExist == null)
                    {

                        await InsertAsync(value, connection, "Update");
                        return Json(new { Message = "Record updated Successfully" });
                    }
                    else
                    {
                        throw new ProcessException("Username already exists");
                    }


                }
                else
                {
                    throw new ProcessException("No Records Found");
                }



            }
        }

        // DELETE: api/User/5
        public void Delete(int id)
        {
            var identity = (ClaimsIdentity)User.Identity;
            UserMaster role = new UserMaster();
            var userId = identity.Claims
                      .Where(c => c.Type == ClaimTypes.Sid)
                      .Select(c => c.Value);
            using (var connection = new SqlConnection(sqlConnectionString))
            {
                connection.Open();
                role = connection.Query<UserMaster>("update UserMaster set IsActive = 0 where Id = @id", new {  id = id }).FirstOrDefault();
                connection.Close();
            }
            
        }
       
        [Authorize(Roles = "17")]
        public List<RoleMaster> GetRole()
        {
            List<RoleMaster> role = new List<RoleMaster>();
            using (var connection = new SqlConnection(sqlConnectionString))
            {
                connection.Open();
                role = connection.Query<RoleMaster>("Select * from RoleMaster where IsActive = 1").ToList();
                connection.Close();
            }
            return role;
        }
        [Authorize(Roles = "17")]
        public UserMaster GetUserDetails()
        {
            var identity = (ClaimsIdentity)User.Identity;
            UserMaster role = new UserMaster();
            var userId = identity.Claims
                      .Where(c => c.Type == ClaimTypes.Sid)
                      .Select(c => c.Value);
            using (var connection = new SqlConnection(sqlConnectionString))
            {
                connection.Open();
                role = connection.Query<UserMaster>("Select * from UserMaster where User_Id =@value", new { value = userId }).FirstOrDefault();
                connection.Close();
            }
            return role;
        }
        [Authorize(Roles = "17")]
        public List<UserMaster> GetAllUserDetails()
        {
            var identity = (ClaimsIdentity)User.Identity;
            List<UserMaster> role = new List<UserMaster>();

            using (var connection = new SqlConnection(sqlConnectionString))
            {
                connection.Open();
                role = connection.Query<UserMaster>("Select * from UserMaster where IsActive =1").ToList();
                connection.Close();
            }
            return role;
        }

        public async Task<int> InsertAsync(UserMaster objentity,SqlConnection connection,string Action)
        {

            int r = 0;
            try

            {

                var identity = (ClaimsIdentity)User.Identity;
                var userId = identity.Claims.Where(c => c.Type == ClaimTypes.Sid)
                   .Select(c => c.Value).SingleOrDefault();
                var param = new DynamicParameters();

                //  SqlParameter[] param = new SqlParameter[18];
                if (Action == "Insert")
                {
                    param.Add("@Action", "Insert");
                    param.Add("@AddedBy", userId);
                }
                else
                {
                    param.Add("@Action", "Update");
                    param.Add("@ModifiedBy", userId);
                    param.Add("@User_Id", objentity.User_Id);
                }
                 param.Add("@Address", objentity.Address);
                 param.Add("@City", objentity.City);
                 param.Add("@ContactNo", objentity.ContactNo);
                 param.Add("@Country", objentity.Country);
                 param.Add("@FirstName", objentity.FirstName);
                 param.Add("@IsActive", objentity.IsActive);
                 param.Add("@LastName", objentity.LastName);
                 param.Add("@Password", objentity.Password);
                 param.Add("@RoleId", objentity.RoleId);
                 param.Add("@State", objentity.State);
                 param.Add("@User_name", objentity.User_name);
                 param.Add("@UserCode", objentity.UserCode);
                 param.Add("@ArmyNo", objentity.ArmyNo);
                 param.Add("@StartDate", objentity.StartDate);
                 param.Add("@EndDate", objentity.EndDate);
                 param.Add("@Output", SqlDbType.Int);


                await connection.QueryAsync<int>("spUser",param,commandType: CommandType.StoredProcedure);
                
                return r;
            }



            catch (Exception)
            {

                throw;
            }
        }
    }
}

using Dapper;
using StockManagementApi.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web.Http;

namespace StockManagementApi.Controllers
{
    public class CategoryController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];

        // GET: api/CategoryType
        [Authorize(Roles = "17")]
        public IEnumerable<Categories> GetAllCategories()
        {
            List<Categories> categoryType = new List<Categories>();
            using (var connection = new SqlConnection(sqlConnectionString))
            {
                connection.Open();
                categoryType = connection.Query<Categories>("Select ID,Category_Name,Category_desc from CategoryMaster").ToList();
                connection.Close();
            }
            return categoryType;
        }

        // GET: api/CategoryType/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/CategoryType
        [Authorize(Roles = "17")]
        public async Task<IHttpActionResult> AddCategory([FromBody]CategoryType category)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            using (var connection = new SqlConnection(sqlConnectionString))
            {
                connection.Open();

                var catExist = connection.Query<CategoryType>("Select * from CategoryType where Type like @value", new { value = category.Type }).FirstOrDefault();
                if (catExist == null)
                {
                    var identity = (ClaimsIdentity)User.Identity;
                    var userId = identity.Claims
                        .Where(c => c.Type == ClaimTypes.Sid)
                        .Select(c => c.Value);
                    var p = new CategoryType { Type = category.Type,Description = category.Description, AddedBy = userId.ToString(), AddedOn=DateTime.Now, IsActive = category.IsActive };
                    p.ID = connection.Query<int>(@"insert CategoryType(Type,Description,AddedBy,AddedOn,IsActive) values (@Type,@Description,@AddedBy,@AddedOn,@IsActive) select cast(scope_identity() as int)", p).First();
                    return Ok(p);
                }

                else
                {
                    throw new ProcessException("Category type already exists");
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
        // PUT: api/CategoryType/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/CategoryType/5
        public void Delete(int id)
        {
        }
        public async Task<int> InsertAsync(CategoryType objentity, SqlConnection connection, string Action)
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
                    param.Add("@User_Id", objentity.ID);
                }
                param.Add("@Type", objentity.Type);
                param.Add("@Description", objentity.Description);
                param.Add("@IsActive", objentity.IsActive);
                param.Add("@Output", SqlDbType.Int);


           var value=  connection.Query<int>("spcategorytype", param, commandType: CommandType.StoredProcedure);

                return 0;
            }



            catch (Exception)
            {

                throw;
            }
        }
    }
}

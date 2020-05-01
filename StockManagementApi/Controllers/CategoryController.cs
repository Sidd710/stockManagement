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
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web.Http;

namespace StockManagementApi.Controllers
{
    public class CategoryController : ApiController
    {
        string sqlConnectionString = ConfigurationManager.AppSettings["Default"];

        // GET: api/CategoryType
        //[Authorize(Roles = "17")]
        public CategoryListData GetAllCategories()
        {
            //List<Categories> categoryType = new List<Categories>();
            //using (var connection = new SqlConnection(sqlConnectionString))
            //{
            //    connection.Open();
            //    categoryType = connection.Query<Categories>("Select ID,Category_Name,Category_desc from CategoryMaster").ToList();
            //    connection.Close();
            //}
            //return categoryType;
            CategoryListData data = new CategoryListData();
            var connection = new SqlConnection(sqlConnectionString);
            SqlCommand command = new SqlCommand("spManageCategory", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;

            connection.Open();
            
            DataTable dt = new DataTable();

            dt.Load(command.ExecuteReader());
            var list = DataTableToJSONWithJSONNet(dt);
            dynamic json = JsonConvert.DeserializeObject(list);
            data.CategoryList = json;

            return data;
        }

        public dynamic GetAllCategoryTypes()
        {
            //List<Categories> categoryType = new List<Categories>();
            //using (var connection = new SqlConnection(sqlConnectionString))
            //{
            //    connection.Open();
            //    categoryType = connection.Query<Categories>("Select ID,Category_Name,Category_desc from CategoryMaster").ToList();
            //    connection.Close();
            //}
            //return categoryType;

            var connection = new SqlConnection(sqlConnectionString);
            SqlCommand command = new SqlCommand("spManageCategoryType", connection);
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

        // GET: api/CategoryType/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/CategoryType
        //[Authorize(Roles = "17")]
        [HttpPost]
        public async Task<IHttpActionResult> AddCategoryType([FromBody]CategoryType category)
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
                    //var identity = (ClaimsIdentity)User.Identity;
                    //var userId = identity.Claims
                    //    .Where(c => c.Type == ClaimTypes.Sid)
                    //    .Select(c => c.Value);
                    var p = new CategoryType { Type = category.Type,Description = category.Description, /*AddedBy = userId.ToString(),*/ AddedOn =DateTime.Now, IsActive = true, Category_ID = category.Category_ID };
                    p.ID = connection.Query<int>(@"insert CategoryType(Type,Description,AddedOn,IsActive,Category_ID) values (@Type,@Description,@AddedOn,@IsActive,@Category_ID) select cast(scope_identity() as int)", p).First();

                    return Json(new { Message = "Record Inserted Successfully" });
                }   
                else
                {
                    throw new ProcessException("Category type already exists");
                }      
            }


        }
        // POST: api/CategoryType
        //[Authorize(Roles = "17")]
        [HttpPost]
        public async Task<IHttpActionResult> AddCategory([FromBody]Category category)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            using (var connection = new SqlConnection(sqlConnectionString))
            {
                connection.Open();

                var catExist = connection.Query<Category>("Select * from CategoryMaster where Category_Name like @value", new { value = category.Category_Name }).FirstOrDefault();
                if (catExist == null)
                {
                    //var identity = (ClaimsIdentity)User.Identity;
                    //var userId = identity.Claims
                    //    .Where(c => c.Type == ClaimTypes.Sid)
                    //    .Select(c => c.Value);
                    var p = new Category { Category_Code = category.Category_Code, Category_Name= category.Category_Name,Category_desc= category.Category_desc, /*AddedBy = userId.ToString(),*/ AddedOn = DateTime.Now, IsActive = true };
                    p.ID = connection.Query<int>(@"insert CategoryMaster(Category_Code,Category_Name,Category_desc,AddedOn,IsActive) values (@Category_Code,@Category_Name,@Category_desc,@AddedOn,@IsActive) select cast(scope_identity() as int)", p).First();

                    return Json(new { Message = "Record Inserted Successfully" });
                }
                else
                {
                    throw new ProcessException("Category already exists");
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

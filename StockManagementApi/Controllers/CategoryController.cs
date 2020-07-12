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
using System.Transactions;
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
                    var p = new CategoryType { Type = category.Type, Description = category.Description, /*AddedBy = userId.ToString(),*/ AddedOn = DateTime.Now, IsActive = true, Category_ID = category.Category_ID };
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
                    var p = new Category { Category_Code = category.Category_Code, Category_Name = category.Category_Name, Category_desc = category.Category_desc, /*AddedBy = userId.ToString(),*/ AddedOn = DateTime.Now, IsActive = true };
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


                var value = connection.Query<int>("spcategorytype", param, commandType: CommandType.StoredProcedure);

                return 0;
            }



            catch (Exception)
            {

                throw;
            }
        }

        [HttpPut]
        public async Task<IHttpActionResult> DeleteCategory([FromBody]Object Id)
        {
            var categoryId = Convert.ToInt32(Id);
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CategoryExist = connection.Query<FormationList>("Select * from CategoryMaster where ID = @Id", new { Id = categoryId }).FirstOrDefault();
                if (CategoryExist == null)
                {
                    throw new ProcessException("Selected category not exists");
                }
                else
                {
                    string updateQuery = @"UPDATE CategoryMaster Set IsActive = @IsActive where ID = @Id";
                    var result = connection.Execute(updateQuery, new { IsActive = false, Id = categoryId });

                    return Json(new { Message = "Record deleted successfully!" });
                }


            }
        }

        [HttpPut]
        public async Task<IHttpActionResult> DeleteCategoryType([FromBody]Object Id)
        {
            var categoryTypeId = Convert.ToInt32(Id);
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var CategoryTypeExist = connection.Query<FormationList>("Select * from CategoryType where ID = @Id", new { Id = categoryTypeId }).FirstOrDefault();
                if (CategoryTypeExist == null)
                {
                    throw new ProcessException("Selected category type not exists");
                }
                else
                {
                    string updateQuery = @"UPDATE CategoryType Set IsActive = @IsActive where ID = @Id";
                    var result = connection.Execute(updateQuery, new { IsActive = false, Id = categoryTypeId });

                    return Json(new { Message = "Record deleted successfully!" });
                }


            }
        }

        public dynamic GetByCategoryId(int Id)
        {
            var category = new Category();
            var connection = new SqlConnection(sqlConnectionString);
            category = connection.Query<Category>("Select * from CategoryMaster where ID = @Id", new { Id = Id }).FirstOrDefault();
            return category;
        }

        [HttpPost]
        public async Task<IHttpActionResult> UpdateCategory([FromBody]Category value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var category = new Category()
                {
                    Category_Code = value.Category_Code,
                    Category_desc = value.Category_desc,
                    Category_Name = value.Category_Name,
                    IsActive = true,
                    ModifiedBy = 0,
                    ModifiedOn = DateTime.Now,
                    ID = value.ID
                };

                string updateQuery = @"UPDATE CategoryMaster SET Category_Code = @Category_Code,Category_desc=@Category_desc,Category_Name = @Category_Name, IsActive= @IsActive, ModifiedBy= @ModifiedBy, ModifiedOn= @ModifiedOn WHERE ID = @ID";

                var result = connection.Execute(updateQuery, category);
                scope.Complete();
                return Json(new { Message = "Record Updated Successfully" });
            }
        }

        public dynamic GetByCategoryTypeId(int Id)
        {
            var categoryType = new CategoryType();
            var connection = new SqlConnection(sqlConnectionString);
            categoryType = connection.Query<CategoryType>("Select * from CategoryType where ID = @Id", new { Id = Id }).FirstOrDefault();
            return categoryType;
        }

        [HttpPost]
        public async Task<IHttpActionResult> UpdateCategoryType([FromBody]CategoryType value)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            using (TransactionScope scope = new TransactionScope())
            using (var connection = new SqlConnection(sqlConnectionString))
            {


                connection.Open();

                var categoryType = new CategoryType()
                {
                    Category_ID = value.Category_ID,
                    Description = value.Description,
                    IsActive = value.IsActive,
                    ModifiedBy = 0,
                    ModifiedOn = DateTime.Now,
                    Type = value.Type,
                    ID = value.ID
                };

                string updateQuery = @"UPDATE CategoryType SET Category_ID = @Category_ID,Description=@Description,IsActive = @IsActive, ModifiedBy= @ModifiedBy, ModifiedOn= @ModifiedOn, Type= @Type WHERE ID = @ID";

                var result = connection.Execute(updateQuery, categoryType);
                scope.Complete();
                return Json(new { Message = "Record Updated Successfully" });
            }
        }
    }
}

using Dapper;
using StockManagementApi.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace StockManagementApi
{
    public class UserMasterRepository : IDisposable
    {
        // SECURITY_DBEntities it is your context class
        SECURITY_DBEntities context = new SECURITY_DBEntities();
        //This method is used to check and validate the user credentials
         string sqlConnectionString = ConfigurationManager.AppSettings["Default"];
        //private string sqlConnectionString = @"Data Source = DESKTOP-88I76K7;initial catalog=SAMRTHOct23;Integrated Security=True;";
        public UserMaster ValidateUser(string User_Name, string Password)
        {
            UserMaster userMaster = new UserMaster();
            using (var connection = new SqlConnection(sqlConnectionString))
            {
                try
                {
                    connection.Open();
                    var sql = "select * from UserMaster where User_Name = '" + User_Name + "' and Password = '" + Password + "'";

                    var orderDetail = connection.Query<UserMaster>(sql).FirstOrDefault();

                    connection.Close();
                    return orderDetail;

                }
                catch (Exception ex)
                {

                    throw ex;
                }
                
            }
           
        }
        public void Dispose()
        {
          //  context.Dispose();
        }
    }
}
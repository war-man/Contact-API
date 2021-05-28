using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System.Data.SqlClient;
using System.Data;
using WebAPI.Models;

namespace WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ContactsController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public ContactsController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet]
        public JsonResult Get()
        {
            string query = @"
                    select * from dbo.Contacts
                    where IsDeleted = 0 ";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("ContactAPP_DB");
            SqlDataReader myReader;
            using(SqlConnection myCon=new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader); ;

                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult(table);
        }
      [HttpGet("favorites")]
        public JsonResult GetFavorites()
        {
            string query = @"
                    select * from dbo.Contacts
                    where IsDeleted = 0 AND IsFavorite = 1";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("ContactAPP_DB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader); ;

                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult(table);
        }

        [HttpGet("{id}")]
        public JsonResult GetId(int id)
        {
            string query = @"
                    select * from dbo.Contacts
                    where ContactId = " + id + @" 
                    AND IsDeleted = 0"; 
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("ContactAPP_DB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader); ;

                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult(table);
        }



        [HttpPost]
        public JsonResult Post(Contact contact)
        {
            string query = @"
                    insert into dbo.Contacts(FirstName,LastName,Phone,Email)
                    values (
                    '" + contact.FirstName + @"'
                    ,'" + contact.LastName + @"'
                    ,'" + contact.Phone + @"'
                    ,'" + contact.Email + @"'
                    )
                    ";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("ContactAPP_DB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader); ;

                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult("Added Successfully");
        }


        [HttpPut("{id}")]
        public JsonResult Put(int id ,Contact contact)
        {
            string query = @"
                    update dbo.Contacts set 
                    FirstName = '"+contact.FirstName+ @"'
                    ,LastName = '" + contact.LastName + @"'
                    ,Phone = '" + contact.Phone + @"'
                    ,Email = '" + contact.Email + @"'
                    where ContactId = " + id + @" 
                    ";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("ContactAPP_DB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader); ;

                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult("Updated Successfully");
        }

        [HttpPut("favorite/{id}")]
        public JsonResult PutFavorite(int id)
        {
            string query = @"
                    update dbo.Contacts set 
                    IsFavorite =  ~IsFavorite
                    where ContactId = " + id + @" 
                    ";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("ContactAPP_DB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader); ;

                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult("Updated Successfully");
        }


        [HttpDelete("{id}")]
        public JsonResult Delete(int id)
        {
            string query = @"
                    update dbo.Contacts set
                    IsDeleted = 1
                    where ContactId = " + id + @" 
                    ";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("ContactAPP_DB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader); ;

                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult("Deleted Successfully");
        }
    }
}

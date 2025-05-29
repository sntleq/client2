using System.Configuration;
using System.Web.Mvc;
using Fresh_University_Enrollment.Models;
using Npgsql;

namespace Fresh_University_Enrollment.Controllers
{
    public class MainController : Controller
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["Enrollment"].ConnectionString;

        
        // GET: /Login
        public ActionResult MainHome()
        {
            // View is located at Views/Main/Home.cshtml
            return View("~/Views/Main/Home.cshtml");
        }

        public ActionResult Student_Profile()
        {
            var student = GetStudentById((int)Session["Stud_Code"]);
            // View is located at Views/Main/StudentProfile.cshtml
            return View("~/Views/Main/StudentProfile.cshtml", student);
        }

        public ActionResult Student_Enrollment()
        {
            // View is located at Views/Main/StudentEnroll.cshtml
            return View("~/Views/Main/StudentEnroll.cshtml");
        }

        public ActionResult Student_Grade()
        {
            // View is located at Views/Main/ViewGrades.cshtml
            return View("~/Views/Main/ViewGrades.cshtml");
        }

        public ActionResult Student_Schedule()
        {
            // View is located at Views/Main/ClassSchedule.cshtml
            return View("~/Views/Main/ClassSchedule.cshtml");
        }

        public Student GetStudentById(int studCode)
        {
            var student = new Student();

            using (var conn = new NpgsqlConnection(_connectionString))
            {
                conn.Open();
                using (var cmd = new NpgsqlCommand(
            "SELECT stud_id, stud_lname, stud_fname, stud_mname, stud_dob::date AS stud_dob, stud_contact, stud_email, stud_address, stud_password, stud_code FROM student WHERE stud_code = @studCode"
                   , conn))
                {
                    cmd.Parameters.AddWithValue("@studCode", studCode);

                    using (var reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            student.Stud_Id = reader.GetInt32(0);
                            student.Stud_Lname = reader.GetString(1);
                            student.Stud_Fname = reader.GetString(2);
                            student.Stud_Mname = reader.IsDBNull(3) ? null : reader.GetString(3);
                            student.Stud_Dob = reader.GetDateTime(4);
                            student.Stud_Contact = reader.GetString(5);
                            student.Stud_Email = reader.GetString(6);
                            student.Stud_Address = reader.GetString(7);
                            student.Stud_Password = reader.GetString(8);
                            student.Stud_Code = reader.GetInt32(9);
                        }
                    }
                }
            }

            return student;
        }
    }
}
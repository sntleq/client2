using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web.Mvc;
using Fresh_University_Enrollment.Models;
using Npgsql;

namespace Fresh_University_Enrollment.Controllers
{
    public class StudentEnrollmentController : Controller
    {
        private List<Program> GetProgramsFromDatabase()
        {
            var programs = new List<Program>();

            using (var conn = new NpgsqlConnection(connString))
            {
                conn.Open();
                using (var cmd = new NpgsqlCommand("SELECT \"prog_code\", \"prog_title\" FROM \"program\"", conn))
                {
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            programs.Add(new Program
                            {
                                ProgCode = reader.GetString(0),
                                ProgTitle = reader.GetString(1)
                            });
                        }
                    }
                }
            }

            return programs;
        }


        private string connString = ConfigurationManager.ConnectionStrings["Enrollment"].ConnectionString;

        public ActionResult Student_Enrollment()
        {
            var sessionStudCode = Session["Stud_Code"];
            var programs = GetProgramsFromDatabase();

            if (sessionStudCode == null)
            {
                return RedirectToAction("Login", "Account");
            }

            int studCode = Convert.ToInt32(sessionStudCode);
            var student = new Student();

            try
            {
                using (var conn = new NpgsqlConnection(connString))
                {
                    conn.Open();
                    string query = "SELECT * FROM STUDENT WHERE STUD_CODE = @studCode";

                    using (var cmd = new NpgsqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@studCode", studCode);

                        using (var reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                student.Stud_Id = reader.GetInt32(reader.GetOrdinal("stud_id"));
                                student.Stud_Lname = reader["stud_lname"]?.ToString();
                                student.Stud_Fname = reader["stud_fname"]?.ToString();
                                student.Stud_Mname = reader["stud_mname"]?.ToString();
                                student.Stud_Dob = Convert.ToDateTime(reader["stud_dob"]);
                                student.Stud_Contact = reader["stud_contact"]?.ToString();
                                student.Stud_Email = reader["stud_email"]?.ToString();
                                student.Stud_Address = reader["stud_address"]?.ToString();
                                student.Stud_Code = Convert.ToInt32(reader["stud_code"]);
                            }
                            else
                            {
                                ViewBag.ErrorMessage = "Student not found.";
                                return View("~/Views/Shared/Error.cshtml");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMessage = $"Error loading student data: {ex.Message}";
                return View("~/Views/Shared/Error.cshtml");
            }

            // Use full path to ensure it finds the correct view
            ViewBag.Programs = programs;
            return View("~/Views/Main/StudentEnroll.cshtml", student);
        }
    }
}
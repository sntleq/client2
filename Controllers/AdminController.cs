using System.Web.Mvc;
using Fresh_University_Enrollment.Models;
using System.Collections.Generic;
using System.Configuration;
using Npgsql;
namespace Fresh_University_Enrollment.Controllers
{
    public class AdminController : Controller
    {
        private readonly string _connectionString;

        public AdminController()
        {
            _connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DbConnection"].ConnectionString;
        }

        public ActionResult MainAdmin()
        {
            return View("~/Views/Admin/Dashboard.cshtml");
        }

        public ActionResult Admin_Curriculum()
        {
            var programs = GetProgramsFromDatabase();
            var yearSemesterOptions = GetYearSemesterOptions();

            // Create a ViewModel or use ViewBag to pass both to the vieww
            ViewBag.YearSemesterOptions = yearSemesterOptions;

            return View("~/Views/Admin/Curriculum.cshtml", programs);
        }


        public ActionResult Admin_Course()
        {
            // Redirect to CourseController.Index instead of duplicating logic
            return RedirectToAction("Index", "Course");
        }

        public ActionResult Admin_AddCourse()
        {
            return RedirectToAction("Index", "AddProgram"); // Use AddProgramController
        }

        public ActionResult Admin_EditCourse()
        {
            return View("~/Views/Admin/EditProgram.cshtml");
        }
        
        private List<Program> GetProgramsFromDatabase()
        {
            var programs = new List<Program>();

            using (var conn = new NpgsqlConnection(_connectionString))
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

        private List<AcademicYear> GetAcademicYearsFromDatabase()
        {
            var academicYears = new List<AcademicYear>();

            using (var conn = new NpgsqlConnection(_connectionString))
            {
                conn.Open();
                using (var cmd = new NpgsqlCommand("SELECT \"ay_code\", \"ay_start_year\", \"ay_end_year\" FROM \"academic_year\"", conn))
                {
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            academicYears.Add(new AcademicYear
                            {
                                AyCode = reader.GetString(0),
                                AyStartYear = reader.GetInt16(1),
                                AyEndYear = reader.GetInt16(2),
                            });
                        }
                    }
                }
            }

            return academicYears;
        }

        private List<Semester> GetSemesterFromDatabase()
        {
            var semesters = new List<Semester>();

            using (var conn = new NpgsqlConnection(_connectionString))
            {
                conn.Open();
                using (var cmd = new NpgsqlCommand("SELECT \"sem_id\", \"sem_name\" FROM \"semester\"", conn))
                {
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            semesters.Add(new Semester
                            {
                                SemId = reader.GetInt16(0),
                                SemName = reader.GetString(1)
                            });
                        }
                    }
                }
            }

            return semesters;
        }
        
        private List<string> GetYearSemesterOptions()
        {
            var academicYears = GetAcademicYearsFromDatabase();
            var semesters = GetSemesterFromDatabase();

            var result = new List<string>();

            foreach (var ay in academicYears)
            {
                foreach (var sem in semesters)
                {
                    result.Add($"{ay.AyCode} - {sem.SemName}");
                }
            }

            return result;
        }
    }
}
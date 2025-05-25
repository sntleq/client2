using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web.Mvc;
using Fresh_University_Enrollment.Models;
using Npgsql;

namespace Fresh_University_Enrollment.Controllers
{
    public class AddProgramController : Controller
    {
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["DbConnection"].ConnectionString;

        // GET: /AddProgram/
        public ActionResult Index()
        {
            ViewBag.CourseCategories = GetCourseCategories();
            ViewBag.CoursesForPrereq = GetCoursesForPrerequisite();

            return View("~/Views/Admin/AddProgram.cshtml");
        }

        // POST: /AddProgram/AddCourseAjax
        [HttpPost]
[ValidateAntiForgeryToken]
public JsonResult AddCourseAjax(Course course)
{
    if (ModelState.IsValid)
    {
        try
        {
            using (var conn = new NpgsqlConnection(_connectionString))
            {
                conn.Open();

                // Insert into COURSE table
                using (var cmd = new NpgsqlCommand(@"
                    INSERT INTO COURSE (
                        CRS_CODE, 
                        CRS_TITLE, 
                        CTG_CODE, 
                        PREQ_ID, 
                        CRS_UNITS, 
                        CRS_LEC, 
                        CRS_LAB
                    ) VALUES (
                        @code, 
                        @title, 
                        @ctgCode, 
                        @prereq, 
                        @units, 
                        @lec, 
                        @lab)", conn))
                {
                    cmd.Parameters.AddWithValue("code", course.Crs_Code);
                    cmd.Parameters.AddWithValue("title", course.Crs_Title);
                    cmd.Parameters.AddWithValue("ctgCode", course.Ctg_Code);
                    cmd.Parameters.AddWithValue("prereq", (object)course.Preq_Crs_Code ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("units", course.Crs_Units);
                    cmd.Parameters.AddWithValue("lec", course.Crs_Lec);
                    cmd.Parameters.AddWithValue("lab", course.Crs_Lab);

                    cmd.ExecuteNonQuery();
                }

                // Optional: Save to PREREQUISITE table
                if (!string.IsNullOrEmpty(course.Preq_Crs_Code) && course.Preq_Crs_Code != "None")
                {
                    using (var cmd = new NpgsqlCommand(@"
                        DELETE FROM PREREQUISITE WHERE CRS_CODE = @crsCode; -- Avoid duplicate insert
                        INSERT INTO PREREQUISITE (CRS_CODE, PREQ_CRS_CODE)
                        VALUES (@crsCode, @preqCode);", conn))
                    {
                        cmd.Parameters.AddWithValue("crsCode", course.Crs_Code);
                        cmd.Parameters.AddWithValue("preqCode", course.Preq_Crs_Code);
                        cmd.ExecuteNonQuery();
                    }
                }

                return Json(new { success = true, message = "Course added successfully!" });
            }
        }
        catch (Exception ex)
        {
            return Json(new { success = false, message = "Error: " + ex.Message });
        }
    }

    return Json(new { success = false, message = "Invalid input." });
}

        // Helper: Fetch Course Categories
        private List<CourseCategory> GetCourseCategories()
        {
            var categories = new List<CourseCategory>();

            using (var conn = new NpgsqlConnection(_connectionString))
            {
                conn.Open();
                using (var cmd = new NpgsqlCommand("SELECT CTG_CODE, CTG_NAME FROM COURSE_CATEGORY", conn))
                {
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            categories.Add(new CourseCategory
                            {
                                Ctg_Code = reader["CTG_CODE"]?.ToString(),
                                Ctg_Name = reader["CTG_NAME"]?.ToString()
                            });
                        }
                    }
                }
            }

            return categories;
        }

        // Helper: Fetch Courses for Prerequisite Dropdown
        private List<Course> GetCoursesForPrerequisite()
        {
            var courses = new List<Course>();

            using (var conn = new NpgsqlConnection(_connectionString))
            {
                conn.Open();
                using (var cmd = new NpgsqlCommand("SELECT CRS_CODE, CRS_TITLE FROM COURSE ORDER BY CRS_CODE", conn))
                {
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            courses.Add(new Course
                            {
                                Crs_Code = reader["CRS_CODE"]?.ToString(),
                                Crs_Title = reader["CRS_TITLE"]?.ToString()
                            });
                        }
                    }
                }
            }

            return courses;
        }
    }
}
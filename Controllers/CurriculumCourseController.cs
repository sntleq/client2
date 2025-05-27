using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web.Mvc;
using Fresh_University_Enrollment.Models;
using Npgsql;

namespace Fresh_University_Enrollment.Controllers
{
    public class CurriculumCourseController : Controller
    {
        [HttpPost]
        public JsonResult AssignCourses(List<CurriculumCourse> courses)
        {
            var success = false;
            var message = "";

            if (courses == null || courses.Count == 0)
                return Json(new { success = false, message = "No courses selected for assignment." });

            try
            {
                using (var conn = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["Enrollment"].ConnectionString))
                {
                    conn.Open();

                    foreach (var course in courses)
                    {
                        using (var cmd = new NpgsqlCommand(@"
                            INSERT INTO curriculum_course (cur_code, crs_code, cur_year_level, cur_semester, ay_code, prog_code)
                            VALUES (@cur_code, @crs_code, @cur_year_level, @cur_semester, @ay_code, @prog_code)", conn))
                        {
                            cmd.Parameters.AddWithValue("@cur_code", course.CurCode);
                            cmd.Parameters.AddWithValue("@crs_code", course.CrsCode);
                            cmd.Parameters.AddWithValue("@cur_year_level", course.CurYearLevel);
                            cmd.Parameters.AddWithValue("@cur_semester", course.CurSemester);
                            cmd.Parameters.AddWithValue("@ay_code", course.AyCode);
                            cmd.Parameters.AddWithValue("@prog_code", course.ProgCode);

                            cmd.ExecuteNonQuery();
                        }
                    }
                    success = true;
                    message = "Courses assigned successfully.";
                }
            }
            catch (Exception ex)
            {
                message = "An error occurred: " + ex.Message;
            }

            return Json(new { success, message });
        }

        [HttpGet]
        public JsonResult GetAcademicYears(string progCode)
        {
            if (string.IsNullOrEmpty(progCode))
                return Json(new List<object>(), JsonRequestBehavior.AllowGet);

            try
            {
                var academicYears = new List<object>();

                using (var conn = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["Enrollment"].ConnectionString))
                {
                    conn.Open();

                    string sql = @"
                        SELECT DISTINCT ay.ay_code, ay.ay_start_year, ay.ay_end_year
                        FROM curriculum c
                        INNER JOIN academic_year ay ON c.ay_code = ay.ay_code
                        WHERE c.prog_code = @prog_code
                        ORDER BY ay.ay_start_year";

                    using (var cmd = new NpgsqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@prog_code", progCode);

                        using (var reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                var ayCode = reader.GetString(0);
                                var startYear = reader.GetInt32(1);
                                var endYear = reader.GetInt32(2);
                                academicYears.Add(new
                                {
                                    AyCode = ayCode,
                                    DisplayText = $"{startYear}-{endYear}"
                                });
                            }
                        }
                    }
                }

                return Json(academicYears, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return Json(new List<object>(), JsonRequestBehavior.AllowGet);
            }
        }
    }
}

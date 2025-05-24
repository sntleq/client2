
using System.Web.Mvc;

namespace Fresh_University_Enrollment.Controllers
{
    public class AdminController : Controller
    {
        public ActionResult MainAdmin()
        {
            return View("~/Views/Admin/Dashboard.cshtml");
        }
        public ActionResult Admin_Curriculum()
        {
            return View("~/Views/Admin/Curriculum.cshtml");
        }
        public ActionResult Admin_Course()
        {
            return View("~/Views/Admin/Courses.cshtml");
        }
        public ActionResult Admin_AddCourse()
        {
            return View("~/Views/Admin/AddProgram.cshtml");
        }   
        public ActionResult Admin_EditCourse()
        {
            return View("~/Views/Admin/EditProgram.cshtml");
        }
    }
}
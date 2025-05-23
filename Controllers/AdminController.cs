
using System.Web.Mvc;

namespace Fresh_University_Enrollment.Controllers
{
    public class AdminController : Controller
    {
        public ActionResult MainAdmin()
        {
            return View("~/Views/Admin/Dashboard.cshtml");
        }
    }
}
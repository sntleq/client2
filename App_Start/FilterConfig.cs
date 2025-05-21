using System.Web;
using System.Web.Mvc;

namespace Fresh_University_Enrollment
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}

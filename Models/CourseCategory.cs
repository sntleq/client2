using System.Collections.Generic;

namespace Fresh_University_Enrollment.Models;

public class CourseCategory
{
    public string CtgCode { get; set; }
    public string CtgName { get; set; }

    // Navigation Properties
    public ICollection<Course> Courses { get; set; } = new List<Course>();
}
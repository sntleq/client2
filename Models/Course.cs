using System.Collections.Generic;

namespace Fresh_University_Enrollment.Models;

public class Course
{
    public string CrsCode { get; set; }
    public string CrsTitle { get; set; }
    public decimal CrsUnits { get; set; }
    public int CrsLec { get; set; }
    public int CrsLab { get; set; }

    public string? PreqId { get; set; }  // Nullable because it's optional
    public string CtgCode { get; set; }

    // Navigation Properties
    public Course Prerequisite { get; set; }  // Self-referencing foreign key
    public CourseCategory Category { get; set; }
    public ICollection<CurriculumCourse> CurriculumCourses { get; set; } = new List<CurriculumCourse>();
}
using System.Collections.Generic;

namespace EnrollmentSystem.Models;

public class Curriculum
{
    public string CurCode { get; set; }
    public string ProgCode { get; set; }
    public string AyCode { get; set; }

    // Navigation Properties
    public Program Program { get; set; }
    public AcademicYear AcademicYear { get; set; }
    public ICollection<CurriculumCourse> CurriculumCourses { get; set; } = new List<CurriculumCourse>();
}
namespace Fresh_University_Enrollment.Models;

public class CurriculumCourse
{
    public string CurCode { get; set; }
    public string CrsCode { get; set; }
    public int CurYearLevel { get; set; }
    public int CurSemester { get; set; }

    // Navigation Properties
    public Curriculum Curriculum { get; set; }
    public Course Course { get; set; }
}
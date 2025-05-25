namespace Fresh_University_Enrollment.Models
{
    public class Prerequisite
    {
        public string Crs_Code { get; set; }         // Foreign Key to Course
        public string Preq_Crs_Code { get; set; } 
        
        public virtual Course Course { get; set; }           // The dependent course
        public virtual Course PrerequisiteCourse { get; set; }// Foreign Key to Course
    }
}
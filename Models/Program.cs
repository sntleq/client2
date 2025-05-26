using System.Collections.Generic;

namespace EnrollmentSystem.Models;

public class Program
{
    public string ProgCode { get; set; }
    public string ProgTitle { get; set; }

    // Navigation Properties
    public ICollection<Curriculum> Curricula { get; set; } = new List<Curriculum>();
}
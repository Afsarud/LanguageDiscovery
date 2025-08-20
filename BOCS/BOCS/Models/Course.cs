using System.ComponentModel.DataAnnotations;

namespace BOCS.Models
{
    public class Course
    {
        public int Id { get; set; }
        [Required, StringLength(120)]
        public string Title { get; set; } = default!;
        public bool IsActive { get; set; } = true;
        [StringLength(512)]
        public string? ThumbnailUrl { get; set; }
        public ICollection<CourseEnrollment> Enrollments { get; set; } = new List<CourseEnrollment>();
    }
}

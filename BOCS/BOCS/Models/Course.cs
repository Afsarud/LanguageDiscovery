﻿using System.ComponentModel.DataAnnotations;

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
        public int DurationDays { get; set; }
        public int PriceBdt { get; set; }
        [StringLength(20)]
        public string? LatestYoutubeId { get; set; }
        public ICollection<CourseEnrollment> Enrollments { get; set; } = new List<CourseEnrollment>();
        public ICollection<CourseLesson> Lessons { get; set; } = new List<CourseLesson>();
        // ✅ নতুন
        public ICollection<CourseSubject> Subjects { get; set; } = new List<CourseSubject>();
    }
}

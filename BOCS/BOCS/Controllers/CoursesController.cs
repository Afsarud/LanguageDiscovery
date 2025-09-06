using BOCS.Data;
using BOCS.Models;
using BOCS.ModelsView;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace BOCS.Controllers
{
    public class CoursesController : Controller
    {
        private readonly UserManager<Users> _userManager; 
        private readonly AppDbContext _db;
        public CoursesController(AppDbContext db, UserManager<Users> userManager)
        {
            _db = db;
            _userManager = userManager;
        }
        public async Task<IActionResult> CourseIndex(string? q, string? sort = "recent")
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            var query = _db.Courses
                .Where(c => c.IsActive)
                .Select(c => new CourseListItemVM
                {
                    Id = c.Id,
                    Title = c.Title,
                    Summary = "",              // চাইলে Course মডেলে Summary যোগ করে আনবে
                    TeacherName = null,        // Teacher রিলেশন থাকলে সেট করো
                    ThumbnailUrl = c.ThumbnailUrl,       // ইমেজ না থাকলে placeholder ইউজ হবে
                    IsActive = c.IsActive,
                    IsNew = false,             // চাইলেই CreatedAt দেখে true করো
                    IsEnrolled = userId != null && _db.Enrollments
                        .Any(e => e.StudentId == userId && e.CourseId == c.Id && e.IsApproved && !e.IsArchived)
                });

            if (!string.IsNullOrWhiteSpace(q))
                query = query.Where(x => x.Title.Contains(q));

            query = sort switch
            {
                "title" => query.OrderBy(x => x.Title),
                "popular" => query.OrderByDescending(x => x.IsEnrolled),
                _ => query.OrderByDescending(x => x.IsNew).ThenBy(x => x.Title)
            };

            var list = await query.AsNoTracking().ToListAsync();
            ViewData["q"] = q;
            ViewData["sort"] = sort;
            return View("CourseIndex", list);
        }
        
        public async Task<IActionResult> Details(int id)
        {
            var course = await _db.Courses
                .Include(c => c.Enrollments)
                .FirstOrDefaultAsync(c => c.Id == id);

            if (course == null) return NotFound();

            var vm = new CourseListItemVM
            {
                Id = course.Id,
                Title = course.Title,
                
                Summary = "", // প্রয়োজনে ডাটার থেকে আনবে
                IsActive = course.IsActive
            };

            return View(vm);
        }
        public async Task<IActionResult> Index(string? q)
        {
            var query = _db.Courses.AsNoTracking();

            if (!string.IsNullOrWhiteSpace(q))
                query = query.Where(c => c.Title.Contains(q));

            var list = await query
                .OrderBy(c => c.Title)
                .Select(c => new CourseCatalogItemVM
                {
                    Id = c.Id,
                    Title = c.Title,
                    ThumbnailUrl = c.ThumbnailUrl,
                    DurationDays =c.DurationDays,
                    PriceBdt = c.PriceBdt,
                    NotificationCount = 0
                })
                .ToListAsync();

            ViewBag.Query = q;
            return View(list);
        }

        // ========== Course Info (Screenshot-2) ==========
        //public async Task<IActionResult> Info(int id)
        //{
        //    var course = await _db.Courses.AsNoTracking().FirstOrDefaultAsync(c => c.Id == id);
        //    if (course == null) return NotFound();

        //    var vm = new CourseInfoVM
        //    {
        //        Id = course.Id,
        //        Title = course.Title,
        //        ThumbnailUrl = course.ThumbnailUrl,
        //        DurationDays = course.DurationDays,
        //        PriceBdt = course.PriceBdt,
        //        LatestYoutubeId = "ysz5S6PUM-U", // ডিফল্ট/লেটেস্ট
        //        Outlines = new()
        //{
        //    new OutlineGroupVM {
        //        Title = "Ocular Outlines",
        //        Items = new()
        //        {
        //            new OutlineItemVM{ Label="Embryology 1 — Dr Prosun",              YoutubeId="dQw4w9WgXcQ"},
        //            new OutlineItemVM{ Label="Basic Cornea Sclera Eyelid — Dr Sharah", YoutubeId="aqz-KE-bpKQ"},
        //            new OutlineItemVM{ Label="Uvea Orbit Paranasal Sinus — Dr Bipul",  YoutubeId="hY7m5jjJ9mM"},
        //            new OutlineItemVM{ Label="Lens Glaucoma anatomy — Dr Bipul",       YoutubeId="3JZ_D3ELwOQ"},
        //            new OutlineItemVM{ Label="… add more ocular anatomy courses",      YoutubeId="ysz5S6PUM-U"}
        //        }
        //    },
        //    new OutlineGroupVM {
        //        Title = "Ocular Physiology",
        //        Items = new()
        //        {
        //            new OutlineItemVM{ Label="BSV 1 — Dr Arif",  YoutubeId="ktlTxC4QG8g"},
        //            new OutlineItemVM{ Label="BSV 2 — Dr Arif",  YoutubeId="M7lc1UVf-VE"},
        //            new OutlineItemVM{ Label="Physiology of Vision 1 — Dr Mohammad", YoutubeId="ScMzIvxBSi4"}
        //        }
        //    },
        //    new OutlineGroupVM {
        //        Title = "Pharmacology",
        //        Items = new()
        //        {
        //            new OutlineItemVM{ Label="Ocular Pharmacology — Dr Shahrina", YoutubeId="wTcNtgA6gHs"}
        //        }
        //    },
        //    new OutlineGroupVM {
        //        Title = "Optics",
        //        Items = new()
        //        {
        //            new OutlineItemVM{ Label="Light & Visual Function — Dr Mohammad", YoutubeId="e-ORhEE9VVg"},
        //            new OutlineItemVM{ Label="Refraction of Light — Dr Arif",        YoutubeId="fJ9rUzIMcZQ"}
        //        }
        //    },
        //    new OutlineGroupVM {
        //        Title = "Ocular Pathology",
        //        Items = new()
        //        {
        //            new OutlineItemVM{ Label="Eyelid 1 — Dr Shahrina", YoutubeId="kXYiU_JCYtU"},
        //            new OutlineItemVM{ Label="Eyelid 2 — Dr Shahrina", YoutubeId="Zi_XLOBDo_Y"},
        //            new OutlineItemVM{ Label="Orbit — Dr Shahrina",    YoutubeId="9bZkp7q19f0"}
        //        }
        //    }
        //}
        //    };

        //    return View(vm);
        //}
        // GET: /Courses/Info/5

        public async Task<IActionResult> Info(int id)
        {
            // 1) কোর্স + Published লেসনগুলোর মিনিমাম ডাটা
            var raw = await _db.Courses
                .AsNoTracking()
                .Where(c => c.Id == id)
                .Select(c => new
                {
                    c.Id,
                    c.Title,
                    c.ThumbnailUrl,
                    c.DurationDays,
                    c.PriceBdt,
                    Lessons = c.Lessons
                        .Where(l => l.IsPublished)
                        .OrderBy(l => l.SortOrder)
                        .Select(l => new
                        {
                            l.Title,
                            l.YoutubeId,
                            l.SortOrder,
                            l.SubjectId,
                            SubjectTitle = l.Subject != null ? l.Subject.Title : null,
                            SubjectOrder = l.Subject != null ? (int?)l.Subject.SortOrder : null
                        })
                        .ToList()
                })
                .FirstOrDefaultAsync();

            if (raw == null) return NotFound();

            // 2) ইন-মেমরি গ্রুপ: SubjectOrder null হলে শেষে; Title null হলে "General"
            var groups = raw.Lessons
                .GroupBy(l => new
                {
                    Order = l.SubjectOrder ?? int.MaxValue,
                    Title = string.IsNullOrWhiteSpace(l.SubjectTitle) ? "General" : l.SubjectTitle
                })
                .OrderBy(g => g.Key.Order)
                .ThenBy(g => g.Key.Title, StringComparer.CurrentCulture)
                .Select(g => new OutlineGroupVM
                {
                    Title = g.Key.Title,
                    Items = g
                        .OrderBy(x => x.SortOrder)
                        .Select(x => new OutlineItemVM
                        {
                            Label = x.Title,
                            YoutubeId = x.YoutubeId
                        })
                        .ToList()
                })
                .Where(g => g.Items.Count > 0) // খালি সাবজেক্ট গ্রুপ বাদ
                .ToList();

            // 3) ফ্ল্যাট আইডি + স্টার্টিং ভিডিও
            var flatIds = groups.SelectMany(g => g.Items).Select(i => i.YoutubeId).ToList();
            var initial = flatIds.FirstOrDefault();

            var vm = new CourseInfoVM
            {
                Id = raw.Id,
                Title = raw.Title,
                ThumbnailUrl = raw.ThumbnailUrl,
                DurationDays = raw.DurationDays,
                PriceBdt = raw.PriceBdt,
                CreatedBy = "Admin",

                Outlines = groups,
                LessonIds = flatIds,
                LatestYoutubeId = string.IsNullOrWhiteSpace(initial) ? null : initial
            };

            return View(vm);
        }

        //public async Task<IActionResult> Info(int id)
        //{
        //    var vm = await _db.Courses
        //        .AsNoTracking()
        //        .Where(c => c.Id == id)
        //        .Select(c => new CourseInfoVM
        //        {
        //            Id = c.Id,
        //            Title = c.Title,
        //            ThumbnailUrl = c.ThumbnailUrl,
        //            DurationDays = c.DurationDays,
        //            PriceBdt = c.PriceBdt,
        //            CreatedBy = "Admin",

        //            Outlines = new List<OutlineGroupVM>
        //            {
        //        new OutlineGroupVM
        //        {
        //            Title = "Course Lessons",
        //            Items = c.Lessons
        //                .Where(l => l.IsPublished)
        //                .OrderBy(l => l.SortOrder)
        //                .Select(l => new OutlineItemVM
        //                {
        //                    Label = l.Title,
        //                    YoutubeId = l.YoutubeId
        //                })
        //                .ToList()
        //        }
        //            },

        //            // indexing-এর জন্য ফ্ল্যাট আইডি লিস্ট
        //            LessonIds = c.Lessons
        //                .Where(l => l.IsPublished)
        //                .OrderBy(l => l.SortOrder)
        //                .Select(l => l.YoutubeId)
        //                .ToList(),

        //            // স্টার্টিং ভিডিও
        //            LatestYoutubeId = c.Lessons
        //                .Where(l => l.IsPublished)
        //                .OrderBy(l => l.SortOrder)
        //                .Select(l => l.YoutubeId)
        //                .FirstOrDefault()
        //        })
        //        .FirstOrDefaultAsync();

        //    if (vm == null) return NotFound();

        //    if (string.IsNullOrWhiteSpace(vm.LatestYoutubeId))
        //        vm.LatestYoutubeId = null;

        //    return View(vm);
        //}

        [HttpGet]
        public async Task<IActionResult> Enroll(int id)
        {
            var course = await _db.Courses
                .AsNoTracking()
                .Where(c => c.Id == id)
                .Select(c => new { c.Id, c.Title, c.PriceBdt })
                .FirstOrDefaultAsync();

            if (course == null) return NotFound();

            var vm = new EnrollmentCreateVM
            {
                CourseId = course.Id,
                CourseTitle = course.Title,
                CoursePriceBdt = course.PriceBdt
            };
            return View(vm);
        }

        [HttpPost, ValidateAntiForgeryToken]
        public async Task<IActionResult> Enroll(EnrollmentCreateVM vm)
        {
            if (!ModelState.IsValid) return View(vm);

            var course = await _db.Courses.AsNoTracking().FirstOrDefaultAsync(x => x.Id == vm.CourseId);
            if (course == null) return NotFound();

            var userId = _userManager.GetUserId(User);

            var enroll = new CourseEnrollment
            {
                CourseId = vm.CourseId,
                StudentId = userId,
                CreatedAt = DateTime.UtcNow,
                AccessType = vm.Access,
                PaymentMethod = vm.PaymentMethod,
                TransactionId = vm.TransactionId,
                SenderNumber = vm.SenderNumber,
                MobileNumber = vm.MobileNumber,
                PriceAtEnrollment = course.PriceBdt,
                IsApproved = false,
                IsArchived = false
            };

            _db.Enrollments.Add(enroll);
            await _db.SaveChangesAsync();

            TempData["StatusMessage"] = "✅ Enrollment submitted. We will review your payment.";
            return RedirectToAction(nameof(Info), new { id = vm.CourseId });
        }
    }
}

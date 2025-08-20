using BOCS.Data;
using BOCS.ModelsView;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace BOCS.Controllers
{
    public class CoursesController : Controller
    {
        private readonly AppDbContext _db;
        public CoursesController(AppDbContext db) => _db = db;
        //public IActionResult CourseIndex()
        //{
        //    return View();
        //}
        // GET: /Courses
        public async Task<IActionResult> CourseIndex(string? q, string? sort = "recent")
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);

            // প্রজেকশন -> VM
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
        // GET: /Courses/Details/5
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
                    // Duration/Price – demo placeholders
                    DurationDays = 180,
                    PriceBdt = 15000,
                    NotificationCount = 0
                })
                .ToListAsync();

            ViewBag.Query = q;
            return View(list); // Views/Courses/Index.cshtml
        }

        // ========== Course Info (Screenshot-2) ==========
        public async Task<IActionResult> Info(int id)
        {
            var course = await _db.Courses.AsNoTracking().FirstOrDefaultAsync(c => c.Id == id);
            if (course == null) return NotFound();

            var vm = new CourseInfoVM
            {
                Id = course.Id,
                Title = course.Title,
                ThumbnailUrl = course.ThumbnailUrl,
                LatestYoutubeId = "ysz5S6PUM-U", // ডিফল্ট/লেটেস্ট
                Outlines = new()
        {
            new OutlineGroupVM {
                Title = "Ocular Outlines",
                Items = new()
                {
                    new OutlineItemVM{ Label="Embryology 1 — Dr Prosun",              YoutubeId="dQw4w9WgXcQ"},
                    new OutlineItemVM{ Label="Basic Cornea Sclera Eyelid — Dr Sharah", YoutubeId="aqz-KE-bpKQ"},
                    new OutlineItemVM{ Label="Uvea Orbit Paranasal Sinus — Dr Bipul",  YoutubeId="hY7m5jjJ9mM"},
                    new OutlineItemVM{ Label="Lens Glaucoma anatomy — Dr Bipul",       YoutubeId="3JZ_D3ELwOQ"},
                    new OutlineItemVM{ Label="… add more ocular anatomy courses",      YoutubeId="ysz5S6PUM-U"}
                }
            },
            new OutlineGroupVM {
                Title = "Ocular Physiology",
                Items = new()
                {
                    new OutlineItemVM{ Label="BSV 1 — Dr Arif",  YoutubeId="ktlTxC4QG8g"},
                    new OutlineItemVM{ Label="BSV 2 — Dr Arif",  YoutubeId="M7lc1UVf-VE"},
                    new OutlineItemVM{ Label="Physiology of Vision 1 — Dr Mohammad", YoutubeId="ScMzIvxBSi4"}
                }
            },
            new OutlineGroupVM {
                Title = "Pharmacology",
                Items = new()
                {
                    new OutlineItemVM{ Label="Ocular Pharmacology — Dr Shahrina", YoutubeId="wTcNtgA6gHs"}
                }
            },
            new OutlineGroupVM {
                Title = "Optics",
                Items = new()
                {
                    new OutlineItemVM{ Label="Light & Visual Function — Dr Mohammad", YoutubeId="e-ORhEE9VVg"},
                    new OutlineItemVM{ Label="Refraction of Light — Dr Arif",        YoutubeId="fJ9rUzIMcZQ"}
                }
            },
            new OutlineGroupVM {
                Title = "Ocular Pathology",
                Items = new()
                {
                    new OutlineItemVM{ Label="Eyelid 1 — Dr Shahrina", YoutubeId="kXYiU_JCYtU"},
                    new OutlineItemVM{ Label="Eyelid 2 — Dr Shahrina", YoutubeId="Zi_XLOBDo_Y"},
                    new OutlineItemVM{ Label="Orbit — Dr Shahrina",    YoutubeId="9bZkp7q19f0"}
                }
            }
        }
            };

            return View(vm);
        }
    }
}

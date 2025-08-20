using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using BOCS.Data;
using BOCS.Models;

namespace BOCS.Controllers
{
    [Authorize(Roles = "Admin")]
    [Route("admin/courses")]
    public class CoursesAdminController : Controller
    {
        private readonly AppDbContext _db;
        private readonly IWebHostEnvironment _env;

        private static readonly string[] _allowedExt = { ".jpg", ".jpeg", ".png", ".webp" };
        private const long _maxFileSize = 2 * 1024 * 1024; // 2MB
        private const string _folderRel = "/uploads/courses"; // under wwwroot

        public CoursesAdminController(AppDbContext db, IWebHostEnvironment env)
        {
            _db = db;
            _env = env;
        }

        // GET: /admin/courses
        [HttpGet("")]
        public async Task<IActionResult> Index(string? q)
        {
            var courses = _db.Courses.AsQueryable();
            if (!string.IsNullOrWhiteSpace(q))
                courses = courses.Where(c => c.Title.Contains(q));

            ViewBag.Query = q;
            return View(await courses
                .OrderByDescending(c => c.IsActive).ThenBy(c => c.Title)
                .AsNoTracking()
                .ToListAsync());
        }

        // GET: /admin/courses/create
        [HttpGet("create")]
        public IActionResult Create() => View(new Course { IsActive = true });

        // POST: /admin/courses/create
        [HttpPost("create")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Title,IsActive")] Course model, IFormFile? thumbnail)
        {
            if (!ModelState.IsValid) return View(model);

            if (thumbnail != null && thumbnail.Length > 0)
            {
                var saved = await SaveImageAsync(thumbnail);
                if (saved == null) return View(model); // ModelState-এ error সেট হয়ে গেছে
                model.ThumbnailUrl = saved;
            }

            _db.Courses.Add(model);
            await _db.SaveChangesAsync();
            TempData["StatusMessage"] = "✅ Course created.";
            return RedirectToAction(nameof(Index));
        }

        // GET: /admin/courses/edit/5
        [HttpGet("edit/{id:int}")]
        public async Task<IActionResult> Edit(int id)
        {
            var course = await _db.Courses.FindAsync(id);
            if (course == null) return NotFound();
            return View(course);
        }

        // POST: /admin/courses/edit/5
        [HttpPost("edit/{id:int}")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,Title,IsActive,ThumbnailUrl")] Course model, IFormFile? thumbnail)
        {
            if (id != model.Id) return BadRequest();
            if (!ModelState.IsValid) return View(model);

            var entity = await _db.Courses.FindAsync(id);
            if (entity == null) return NotFound();

            entity.Title = model.Title;
            entity.IsActive = model.IsActive;

            if (thumbnail != null && thumbnail.Length > 0)
            {
                // নতুন ফাইল সেভ
                var saved = await SaveImageAsync(thumbnail);
                if (saved == null) return View(model);
                // পুরনো ফাইল ডিলিট (থাকলে)
                DeletePhysicalFile(entity.ThumbnailUrl);
                entity.ThumbnailUrl = saved;
            }
            // যদি thumbnail না দেওয়া হয়, পুরনো ThumbnailUrl থাকবে

            await _db.SaveChangesAsync();
            TempData["StatusMessage"] = "✅ Course updated.";
            return RedirectToAction(nameof(Index));
        }

        // GET: /admin/courses/delete/5
        [HttpGet("delete/{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            var c = await _db.Courses.AsNoTracking().FirstOrDefaultAsync(x => x.Id == id);
            if (c == null) return NotFound();
            return View(c);
        }

        // POST: /admin/courses/delete/5
        [HttpPost("delete/{id:int}")]
        [ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var entity = await _db.Courses.FindAsync(id);
            if (entity == null) return NotFound();

            // ফিজিক্যাল ফাইল ডিলিট
            DeletePhysicalFile(entity.ThumbnailUrl);

            _db.Courses.Remove(entity);
            await _db.SaveChangesAsync();

            TempData["StatusMessage"] = "🗑️ Course deleted.";
            return RedirectToAction(nameof(Index));
        }

        // ---------- helpers ----------
        private async Task<string?> SaveImageAsync(IFormFile file)
        {
            var ext = Path.GetExtension(file.FileName).ToLowerInvariant();
            if (!_allowedExt.Contains(ext))
            {
                ModelState.AddModelError(string.Empty, "Only JPG, PNG, WEBP allowed.");
                return null;
            }
            if (file.Length > _maxFileSize)
            {
                ModelState.AddModelError(string.Empty, "Max file size 2MB.");
                return null;
            }

            var root = _env.WebRootPath;
            var folderAbs = Path.Combine(root, _folderRel.TrimStart('/').Replace('/', Path.DirectorySeparatorChar));
            Directory.CreateDirectory(folderAbs);

            var fileName = $"{Guid.NewGuid():N}{ext}";
            var absPath = Path.Combine(folderAbs, fileName);
            using (var stream = System.IO.File.Create(absPath))
            {
                await file.CopyToAsync(stream);
            }

            // return URL path
            return $"{_folderRel}/{fileName}".Replace("\\", "/");
        }

        private void DeletePhysicalFile(string? urlPath)
        {
            if (string.IsNullOrWhiteSpace(urlPath)) return;
            try
            {
                var abs = Path.Combine(_env.WebRootPath, urlPath.TrimStart('/').Replace('/', Path.DirectorySeparatorChar));
                if (System.IO.File.Exists(abs))
                    System.IO.File.Delete(abs);
            }
            catch { /* ignore */ }
        }
    }
}

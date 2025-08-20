using BOCS.Models;
using BOCS.ModelsView;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace BOCS.Controllers
{
    public class AccountController : Controller
    {
        private readonly SignInManager<Users> signInManager;
        private readonly UserManager<Users> userManager;
        private readonly RoleManager<IdentityRole> roleManager;

        public AccountController(SignInManager<Users> signInManager, UserManager<Users> userManager, RoleManager<IdentityRole> roleManager)
        {
            this.signInManager = signInManager;
            this.userManager = userManager;
            this.roleManager = roleManager;
        }
        [AllowAnonymous]
        [HttpGet]
        public IActionResult Login(string? returnUrl = null)
        {
            ViewData["ReturnUrl"] = returnUrl;
            return View();
        }

        [AllowAnonymous]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(LoginViewModel model, string? returnUrl = null)
        {
            if (!ModelState.IsValid) return View(model);

            var loginId = model.Email?.Trim();

            // ইমেইল না পেলে ইউজারনেম দিয়ে চেষ্টা
            var user = await userManager.FindByEmailAsync(loginId)
                       ?? await userManager.FindByNameAsync(loginId);

            if (user != null)
            {
                // ✅ session cookie (browser close = auto logout)
                var result = await signInManager.PasswordSignInAsync(
                    user,
                    model.Password,
                    isPersistent: false,     // <-- RememberMe ইগনোর; ব্রাউজার ক্লোজ হলে লগআউট
                    lockoutOnFailure: true   // নিরাপত্তার জন্য ভাল
                );

                if (result.Succeeded)
                    return LocalRedirect(returnUrl ?? Url.Action("Index", "Home")!);

                if (result.IsLockedOut)
                {
                    ModelState.AddModelError(string.Empty, "Account locked. Please try later.");
                    return View(model);
                }
            }

            ModelState.AddModelError(string.Empty, "Invalid login!");
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Logout()
        {
            await signInManager.SignOutAsync();
            await HttpContext.SignOutAsync(IdentityConstants.ApplicationScheme);
            await HttpContext.SignOutAsync(IdentityConstants.ExternalScheme);
            await HttpContext.SignOutAsync(IdentityConstants.TwoFactorUserIdScheme);
            return RedirectToAction("Login", "Account");
        }
        [HttpGet]
        [AllowAnonymous]
        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Register(RegisterViewModel model)
        {
            if (!ModelState.IsValid)
                return View(model);

            var email = model.Email.Trim();

            // Email already exist check
            if (await userManager.FindByEmailAsync(email) is not null)
            {
                ModelState.AddModelError(nameof(model.Email), "Email already in use.");
                return View(model);
            }

            // নতুন User তৈরি
            var user = new Users
            {
                FullName = model.Name,
                Email = email,
                UserName = email,
                EmailConfirmed = false,
                Role = model.Role,                  // ✅ Role assign হবে
                CreatedDate = DateTime.Now
            };

            var result = await userManager.CreateAsync(user, model.Password);

            if (!result.Succeeded)
            {
                foreach (var e in result.Errors)
                    ModelState.AddModelError("", e.Description);

                return View(model);
            }

            // যদি ASP.NET Identity Role System ব্যবহার করেন
            if (!string.IsNullOrEmpty(model.Role))
            {
                if (await roleManager.RoleExistsAsync(model.Role))
                {
                    await userManager.AddToRoleAsync(user, model.Role);
                }
            }

            await signInManager.SignInAsync(user, isPersistent: false);

            return RedirectToAction("Login", "Account");
        }

        [HttpGet]
        public IActionResult VerifyEmail() => View(new VerifyEmailViewModel());

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> VerifyEmail(VerifyEmailViewModel model)
        {
            if (!ModelState.IsValid) return View(model);

            var email = model.Email?.Trim();
            var user = await userManager.FindByEmailAsync(email);
            if (user is null)
            {
                ModelState.AddModelError(nameof(model.Email), "No account found with this email.");
                return View(model);
            }
            return RedirectToAction("ChangePassword", "Account", new {userName= user.UserName});
        }

        [HttpGet]
        public IActionResult ChangePassword()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ChangePassword(ChangePasswordViewModel model)
        {
            if (!ModelState.IsValid)
                return View(model);

            var email = model.Email.Trim();
            var user = await userManager.FindByEmailAsync(email);

            if (user is null)
            {
                ModelState.AddModelError(nameof(model.Email), "Email not found.");
                return View(model);
            }

            var resetToken = await userManager.GeneratePasswordResetTokenAsync(user);
            var result = await userManager.ResetPasswordAsync(user, resetToken, model.NewPassword);

            if (!result.Succeeded)
            {
                foreach (var e in result.Errors)
                    ModelState.AddModelError("", e.Description);
                return View(model);
            }
            await signInManager.SignOutAsync();
            TempData["SuccessMessage"] = "Password changed successfully. Please log in with your new password.";
            return RedirectToAction("Login", "Account");
        }

    }

}

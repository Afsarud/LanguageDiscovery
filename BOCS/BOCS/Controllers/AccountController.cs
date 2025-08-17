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
        [HttpGet]
        public IActionResult Login() 
        {
        return View();  
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(LoginViewModel model)
        {
            if (!ModelState.IsValid) return View(model);

            var email = model.Email?.Trim();
            var user = await userManager.FindByEmailAsync(email);
            if (user == null)
            {
                user = await userManager.FindByNameAsync(email);
            }

            if (user != null)
            {
                var result = await signInManager.PasswordSignInAsync(
                    user, model.Password, model.RememberMe, lockoutOnFailure: false);

                if (result.Succeeded)
                    return RedirectToAction("Index", "Home");
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
            return RedirectToAction("Index", "Home");
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


        //[HttpGet]
        //public IActionResult Register()
        //{
        //    return View();
        //}

        //[HttpPost]
        //[AllowAnonymous]
        //[ValidateAntiForgeryToken]
        //public async Task<IActionResult> Register(RegisterViewModel model)
        //{
        //    if (!ModelState.IsValid) return View(model);

        //    var email = model.Email.Trim();
        //    if (await userManager.FindByEmailAsync(email) is not null)
        //    {
        //        ModelState.AddModelError(nameof(model.Email), "Email already in use.");
        //        return View(model);
        //    }

        //    var user = new Users { FullName = model.Name, Email = email, UserName = email, EmailConfirmed = false };
        //    var result = await userManager.CreateAsync(user, model.Password);

        //    if (!result.Succeeded)
        //    {
        //        foreach (var e in result.Errors) ModelState.AddModelError("", e.Description);
        //        return View(model);
        //    }
        //    await signInManager.SignInAsync(user, isPersistent: false);
        //    return RedirectToAction("Login", "Account");
        //}

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

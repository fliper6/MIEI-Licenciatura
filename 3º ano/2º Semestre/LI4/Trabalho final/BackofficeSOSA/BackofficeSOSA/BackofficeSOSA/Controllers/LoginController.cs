using BackofficeSOSA.Models;
using BackofficeSOSA.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace BackofficeSOSA.Controllers
{
    public class LoginController : Controller
    {
        private ApiServices apiServices = new ApiServices();

        public ActionResult Login()
        {
            return View();
        }
        //Login
        [HttpPost]
        public async Task<ActionResult> Login(Utilizador ut, string ReturnUrl)
        {
            bool isLogged = await apiServices.Login(ut.Email, ut.Password);

            if (isLogged)
            {
                TempData["Success"] = "Login correto!";
                FormsAuthentication.SetAuthCookie(ut.Email, false);
                return RedirectToLocal(ReturnUrl);
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Dados incorretos.");
                return View(ut);
            }
        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToLocal("Admin/Dashboard");
        }

        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            return RedirectToAction("Dashboard", "Admin");
        }
    }
}
using GrabIt.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;

namespace GrabIt.Controllers
{
    [Authorize]
    public class AdminController : Controller
    {
        private GrabItEntities db = new GrabItEntities();
        // GET: Admin
        public ActionResult Index()
        {
            string userGuid = User.Identity.GetUserId();
            USER usr = db.USERS.Where(item => item.UserNetID == userGuid).SingleOrDefault();
            if (usr == null || usr.Enabled != 1)
            {
                return RedirectToAction("Index", "Home");
            }

            return View();
        }
        public ActionResult UserList()
        {
            List<GrabIt.Models.AspNetUser> model = db.AspNetUsers.ToList();
            List<GrabIt.Models.USER> UserList = new List<USER>();
            foreach (GrabIt.Models.AspNetUser usr in model)
            {
                UserList.Add(db.USERS.Where(item => item.UserNetID == usr.Id).SingleOrDefault());
            }

            ViewBag.UserType = db.AspNetRoles.ToList();

            ViewBag.Users = UserList;

            return PartialView("UserList", model);
        }



    }
}
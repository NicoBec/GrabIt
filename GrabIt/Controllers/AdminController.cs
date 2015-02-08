using GrabIt.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrabIt.Controllers
{
    public class AdminController : Controller
    {
        private GrabItEntities db = new GrabItEntities();
        // GET: Admin
        public ActionResult Index()
        {
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

            ViewBag.Users = UserList;

            return View(model);
        }
       


    }
}
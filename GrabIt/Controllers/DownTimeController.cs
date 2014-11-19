using GrabIt.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Microsoft.AspNet.Identity;

namespace GrabIt.Controllers
{
    [Authorize]
    public class DownTimeController : Controller
    {
        private GrabItEntities db = new GrabItEntities();
        // GET: DownTime
        public ActionResult Index()
        {
            string userGuid = User.Identity.GetUserId();

            USER usr = db.USERS.Where(item => item.UserNetID == userGuid).SingleOrDefault();
            if (usr == null)
            {
                return RedirectToAction("GetFullName", "Account");
            }
            else
            {

                if (usr.Enabled == null || usr.Enabled == 0)
                {
                    return RedirectToAction("Index", "Home");

                }

                HttpContext.Session["UserName"] = usr.UserName.Trim();
                HttpContext.Session["UserID"] = usr.UserID;
            }

            List<GrabIt.Models.DOWNTIMEVIEW> Model = db.DOWNTIMEVIEWs.OrderByDescending(item => item.Date).Take(100).ToList();
            return View(Model);
        }

        public PartialViewResult DownTimeAdd()
        {
            ViewBag.Area = db.GLOBALLOOKUPs.Where(item => item.LookupCat == 1).ToList();
            ViewBag.AffectedArea = db.GLOBALLOOKUPs.Where(item => item.LookupCat == 2).ToList();
            ViewBag.ShiftType = db.SHIFTTYPES.ToList();

            return PartialView("");
        }

        public JsonResult getEquipmentTag(string text = "")
        {
            if (text.Length < 3) { return this.Json(new List<string>()); }

            return this.Json(db.DOWNTIMEs.Where(item => item.EquipmentTag.Contains(text)).Select(item => item.EquipmentTag).Distinct().Take(10).ToList());
        }

        public JsonResult getReasons(string text = "")
        {
            if (text.Length <= 3) { return this.Json(new List<string>()); }

            return this.Json(db.DOWNTIMEs.Where(item => item.Reason.Contains(text)).Select(item => item.Reason).Distinct().Take(10).ToList());
        }
        public JsonResult getResponsiblePersons(string text = "")
        {
            if (text.Length < 3) { return this.Json(new List<string>()); }

            return this.Json(db.DOWNTIMEs.Where(item => item.ResponsiblePerson.Contains(text)).Select(item => item.ResponsiblePerson).Distinct().Take(10).ToList());
        }

        public int AddDownTime(string date, string startDatetime, string endDatetime, int area, int affectedArea, string reason, string equipmentTag, string responsiblePerson, string notes, int shiftType, bool addOneDay)
        {
            DOWNTIME newDT = new DOWNTIME();

            newDT.Date = DateTime.Parse(date);
            newDT.StartTime = DateTime.Parse(startDatetime);
            newDT.EndTime = DateTime.Parse(endDatetime);
            newDT.Area = area;
            newDT.AffectedArea = affectedArea;
            newDT.Reason = reason;
            newDT.EquipmentTag = equipmentTag;
            newDT.ResponsiblePerson = responsiblePerson;
            newDT.Notes = notes;
            newDT.ShiftTypeID = shiftType;
            newDT.UserID = (int)HttpContext.Session["UserID"];

            if (addOneDay)
            {
                newDT.EndTime = newDT.EndTime.AddDays(1);
            }

            db.DOWNTIMEs.Add(newDT);
            db.SaveChanges();
            return newDT.DownTimeID;
        }
        public int updateDownTime(int DownTimeID, string date, string startDatetime, string endDatetime, int area, int affectedArea, string reason, string equipmentTag, string responsiblePerson, string notes, int shiftType, bool addOneDay)
        {
            DOWNTIME newDT = db.DOWNTIMEs.Where(item => item.DownTimeID == DownTimeID).SingleOrDefault();

            newDT.Date = DateTime.Parse(date);
            newDT.StartTime = DateTime.Parse(startDatetime);
            newDT.EndTime = DateTime.Parse(endDatetime);
            newDT.Area = area;
            newDT.AffectedArea = affectedArea;
            newDT.Reason = reason;
            newDT.EquipmentTag = equipmentTag;
            newDT.ResponsiblePerson = responsiblePerson;
            newDT.Notes = notes;
            newDT.ShiftTypeID = shiftType;

            if (addOneDay)
            {
                newDT.EndTime = newDT.EndTime.AddDays(1);
            }
            db.SaveChanges();
            return newDT.DownTimeID;
        }
        // [HttpGet]
        public JsonResult getDownTimeByID(int DownTimeID)
        {
            DOWNTIME newDT = db.DOWNTIMEs.Where(item => item.DownTimeID == DownTimeID).SingleOrDefault();
            var obj = new
            {
                DownTimeID = newDT.DownTimeID,
                Date = newDT.Date.ToString("yyyy-MM-dd"),
                StartTime = newDT.StartTime.ToShortTimeString(),
                EndTime = newDT.EndTime.ToShortTimeString(),
                Area = newDT.Area,
                AffectedArea = newDT.AffectedArea,
                Reason = newDT.Reason.Trim(),
                EquipmentTag = newDT.EquipmentTag.Trim(),
                ResponsiblePerson = newDT.ResponsiblePerson.Trim(),
                Notes = newDT.Notes.Trim(),
                ShiftTypeID = newDT.ShiftTypeID
            };

            return this.Json(obj);
            //return this.Json(db.DOWNTIMEs.Where(item => item.DownTimeID == DownTimeID).Select(n => new
            //{
            //    DownTimeID = n.DownTimeID,
            //    Date = n.Date.ToString(),
            //    StartTime = n.StartTime,
            //    EndTime = n.EndTime,
            //    Area = n.Area,
            //    AffectedArea = n.AffectedArea,
            //    Reason = n.Reason,
            //    EquipmentTag = n.EquipmentTag,
            //    ResponsiblePerson = n.ResponsiblePerson,
            //    Notes = n.Notes,
            //    ShiftTypeID = n.ShiftTypeID
            //}).ToList()
            //     .Select(x => new
            //     {
            //         DownTimeID = x.DownTimeID,
            //         Date = x.Date.ToString(),
            //         StartTime = x.StartTime,
            //         EndTime = x.EndTime,
            //         Area = x.Area,
            //         AffectedArea = x.AffectedArea,
            //         Reason = x.Reason,
            //         EquipmentTag = x.EquipmentTag,
            //         ResponsiblePerson = x.ResponsiblePerson,
            //         Notes = x.Notes,
            //         ShiftTypeID = x.ShiftTypeID
            //     }));
        }
    }
}
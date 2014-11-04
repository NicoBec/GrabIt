using GrabIt.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrabIt.Controllers
{
    public class DownTimeController : Controller
    {
        private GrabItEntities db = new GrabItEntities();
        // GET: DownTime
        public ActionResult Index()
        {

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

            if (addOneDay)
            {
                newDT.EndTime = newDT.EndTime.AddDays(1);
            }

            db.DOWNTIMEs.Add(newDT);
            db.SaveChanges();
            return newDT.DownTimeID;
        }
        
    }
}
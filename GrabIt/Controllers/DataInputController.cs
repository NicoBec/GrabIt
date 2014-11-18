using GrabIt.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrabIt.Controllers
{
    [Authorize]
    public class DataInputController : Controller
    {
        // GET: DataInput
        private GrabItEntities db = new GrabItEntities();
        public ActionResult Index()
        {
            return View();
        }
        public JsonResult GetProcessByProcessID(int ProcessID)
        {

            var items = (from u in db.PROCESSES
                 join e in db.PROCESSTYPES on u.ProcessTypeID equals e.ProcessTypeID
                 where u.ProcessID == ProcessID

                  select new
            {
                ShiftTypeID = u.ShiftTypeID,
                Date = u.Date.ToString(),
                StartTime = u.StartTime,
                EndTime = u.EndTime,
                ProcessTypeID = u.ProcessTypeID,
                UserID = u.UserID,
                Completed = u.Completed,
                ProcessCategoryID = e.ProcessCategoryID
            }).SingleOrDefault();

            return Json(items, JsonRequestBehavior.AllowGet);

        }
        public PartialViewResult ProcessAddView()
        {
            // var model = db.GetProcessesByDate("");

            return PartialView("ProcessAddView");
        }
        public PartialViewResult ProcessAddedlist(string date = "")
        {
            DateTime theDate;
            if (date == "")
            {
                theDate = DateTime.Now.Date;

            }
            else
            {
                theDate = DateTime.Parse(date);
            }

            var model = db.ProcessesViews.Where(item => item.Date == theDate).ToList();

            return PartialView(model);
        }
        public PartialViewResult GetShiftType()
        {
            var model = db.SHIFTTYPES.ToList();
            return PartialView(model);
        }
        public PartialViewResult GetProcessType(int catID)
        {
            var model = db.PROCESSTYPES.Where(Item => Item.ProcessCategoryID == catID).ToList();
            return PartialView(model);
        }
        public PartialViewResult GetProcessCat()
        {
            var model = db.PROCESSCATEGORIES.ToList();
            return PartialView(model);
        }
        //measurements
        public PartialViewResult GetMeasurements(int ProcessTypeID)
        {
            Measurements modelItem = new Measurements();

            modelItem.SortByCat(db.MEASUREMENTVIEWs.Where(item => item.ProcessTypeID == ProcessTypeID).ToList());
            var model = modelItem.MeasurementsByCat;

            return PartialView(model);
        }

        public JsonResult GetMeasurementsList(int ProcessTypeID)
        {


            List<MEASUREMENTVIEW> items = db.MEASUREMENTVIEWs.Where(item => item.ProcessTypeID == ProcessTypeID).ToList();
            foreach (MEASUREMENTVIEW mes in items)
            {
                mes.Desc = mes.Desc.Trim();
            }

            return Json(items, JsonRequestBehavior.AllowGet);

        }
        public JsonResult GetMeasurementsByProcessID(int ProcessID)
        {

            var items = db.MEASUREMENTS.Where(item => item.ProcessID == ProcessID).Select(u => new { ID = u.MeasurementTypeID, Value = u.Value });
            return Json(items, JsonRequestBehavior.AllowGet);

        }
        public int checkProcessExist(PROCESS prs)
        {

            PROCESS current = db.PROCESSES.SingleOrDefault(item => item.ShiftTypeID == prs.ShiftTypeID && item.Date == prs.Date && item.ProcessTypeID == prs.ProcessTypeID);
            if (current != null)
            {
                return current.ProcessID;
            }
            else
            {
                return 0;
            }


           
            return prs.ProcessID;
        }
        public int AddProcess(PROCESS prs)
        {

            PROCESS current = db.PROCESSES.SingleOrDefault(item => item.ShiftTypeID == prs.ShiftTypeID && item.Date == prs.Date && item.ProcessTypeID == prs.ProcessTypeID);
            if (current != null)
            {
                current.ShiftTypeID = prs.ShiftTypeID;
                current.Date = prs.Date;
                current.StartTime = prs.StartTime;
                current.EndTime = prs.EndTime;
                current.ProcessTypeID = prs.ProcessTypeID;
                current.UserID = prs.UserID;
                current.Completed = prs.Completed;
               
            }else{
                db.PROCESSES.Add(prs);
            }

           
            db.SaveChanges();
            return prs.ProcessID;
        }
        public int AddMeasurement(MEASUREMENT Measure)
        {
            MEASUREMENT DBMeasure = db.MEASUREMENTS.SingleOrDefault(item => item.MeasurementTypeID == Measure.MeasurementTypeID && item.ProcessID == Measure.ProcessID);
            if (DBMeasure != null)
            {
                DBMeasure.Value = Measure.Value;
                db.SaveChanges();
            }
            else
            {
                db.MEASUREMENTS.Add(Measure);
            }
            db.SaveChanges();

            int pt = db.PROCESSES.Where(item => item.ProcessID == Measure.ProcessID).Select(row => row.ProcessTypeID).SingleOrDefault();
            int count = db.MEASUREMENTLINKs.Where(item => item.ProcessTypeID == pt).Count();
            int mesCount = db.MEASUREMENTS.Where(item => item.ProcessID == Measure.ProcessID).Count();
            if (count == mesCount)
            {
                PROCESS pros = db.PROCESSES.SingleOrDefault(item => item.ProcessID == Measure.ProcessID);
                pros.Completed = true;
                db.SaveChanges();
            }


           
            return Measure.ProcessID;
        }
    }

    public class Measurements
    {
        public List<List<MEASUREMENTVIEW>> MeasurementsByCat = new List<List<MEASUREMENTVIEW>>();

        public void SortByCat(List<MEASUREMENTVIEW> Measures)
        {

            Dictionary<string, int> catsdone = new Dictionary<string, int>();
            int CatCnt = 0;
            foreach (MEASUREMENTVIEW item in Measures)
            {
                item.Desc = item.Desc.Trim();
                if (catsdone.Keys.Contains(item.Category))
                {
                    MeasurementsByCat[catsdone[item.Category]].Add(item);
                }
                else
                {
                    catsdone.Add(item.Category, CatCnt++);

                    MeasurementsByCat.Add(new List<MEASUREMENTVIEW>());

                    MeasurementsByCat[catsdone[item.Category]].Add(item);

                }

            }


        }
    }
}
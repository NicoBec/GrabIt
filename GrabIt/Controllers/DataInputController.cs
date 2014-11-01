using GrabIt.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GrabIt.Controllers
{
    public class DataInputController : Controller
    {
        // GET: DataInput
        private GrabItEntities db = new GrabItEntities();
        public ActionResult Index()
        {


            return View();
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
        public PartialViewResult GetMeasurements(int ProcessTypeID = 3, int MeasurementID = 0)
        {
            Measurements modelItem = new Measurements();

            modelItem.SortByCat(db.MEASUREMENTVIEWs.Where(item => item.ProcessTypeID == ProcessTypeID).ToList());
            var model = modelItem.MeasurementsByCat;

            if (MeasurementID != 0)
            {

            }

            return PartialView(model);
        }

        public JsonResult GetMeasurementsList(int ProcessTypeID = 3)
        {


            List<MEASUREMENTVIEW> items = db.MEASUREMENTVIEWs.Where(item => item.ProcessTypeID == ProcessTypeID).ToList();
            foreach (MEASUREMENTVIEW mes in items)
            {
                mes.Desc = mes.Desc.Trim();
            }

            return Json(items, JsonRequestBehavior.AllowGet);

        }
        public JsonResult GetMeasurementsByProcessID(int ProcessID = 4)
        {

            var items = db.MEASUREMENTS.Where(item => item.ProcessID == ProcessID).Select(u => new {ID = u.MeasurementTypeID,Value = u.Value });
            return Json(items, JsonRequestBehavior.AllowGet);

        }
        public int AddProcess(PROCESS prs)
        {
            db.PROCESSES.Add(prs);
            db.SaveChanges();
            return prs.ProcessID;
        }
        public int AddMeasurement(MEASUREMENT Measure)
        {
            MEASUREMENT DBMeasure = db.MEASUREMENTS.SingleOrDefault(item => item.MeasurementTypeID == Measure.MeasurementTypeID && item.ProcessID == Measure.ProcessID);
            if ( DBMeasure != null)
            {
                DBMeasure.Value = Measure.Value;
                db.SaveChanges();
            }
            else
            {
                db.MEASUREMENTS.Add(Measure);
            }

           
            db.SaveChanges();
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
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
        public PartialViewResult GetMeasurements(int ProcessTypeID = 3)
        {
            Measurements modelItem = new Measurements();

            modelItem.SortByCat(db.MEASUREMENTVIEWs.Where(item => item.ProcessTypeID == ProcessTypeID).ToList());
            var model = modelItem.MeasurementsByCat;
            return PartialView(model);
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
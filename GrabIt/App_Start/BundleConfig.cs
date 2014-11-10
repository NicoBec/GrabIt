using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Optimization;

namespace GrabIt
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                "~/Scripts/jquery-1.10.2.js"
                , "~/Scripts/jquery.dataTables.js"
                , "~/Scripts/dataTables.bootstrap.js"
                ,"~/Scripts/bootstrap-timepicker.js"
                , "~/Scripts/bootstrapValidator.js"
                , "~/Scripts/bootstrap-dialog.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                "~/Scripts/jquery.unobtrusive*",
                "~/Scripts/jquery.validate*"));

            bundles.Add(new ScriptBundle("~/bundles/knockout").Include(
                "~/Scripts/knockout-{version}.js",
                "~/Scripts/knockout.validation.js"));

            bundles.Add(new ScriptBundle("~/bundles/app").Include(
                "~/Scripts/sammy-{version}.js",
                "~/Scripts/app/common.js",
                "~/Scripts/app/app.datamodel.js",
                "~/Scripts/app/app.viewmodel.js",
                "~/Scripts/app/home.viewmodel.js",
                "~/Scripts/app/_run.js"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                "~/Scripts/bootstrap.js",
                "~/Scripts/jquery-ui-1.11.2.custom/jquery-ui.js",
                "~/Scripts/respond.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                 "~/Content/bootstrap.css",
                 "~/Scripts/jquery-ui-1.11.2.custom/jquery-ui.css",
                 "~/Content/dataTables.bootstrap.css",
                  "~/Content/jquery.dataTables.css",
                  "~/Scripts/jquery-ui-1.11.2.custom/jquery-ui.theme.css",
                  "~/Content/bootstrap-timepicker.css",
                  "~/Content/bootstrapValidator.css",
                  "~/Content/bootstrap-dialog.css",
                 "~/Content/Site.css"));

            // Set EnableOptimizations to false for debugging. For more information,
            // visit http://go.microsoft.com/fwlink/?LinkId=301862
            BundleTable.EnableOptimizations = true;
        }
    }
}

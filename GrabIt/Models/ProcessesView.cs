//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace GrabIt.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class ProcessesView
    {
        public int ProcessID { get; set; }
        public string Shift { get; set; }
        public System.DateTime Date { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string Desc { get; set; }
        public string UserName { get; set; }
        public bool Completed { get; set; }
    }
}

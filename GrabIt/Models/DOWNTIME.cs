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
    
    public partial class DOWNTIME
    {
        public int DownTimeID { get; set; }
        public System.DateTime Date { get; set; }
        public System.DateTime StartTime { get; set; }
        public System.DateTime EndTime { get; set; }
        public int Area { get; set; }
        public int AffectedArea { get; set; }
        public string Reason { get; set; }
        public string EquipmentTag { get; set; }
        public string ResponsiblePerson { get; set; }
        public string Notes { get; set; }
        public Nullable<int> ShiftTypeID { get; set; }
        public Nullable<int> UserID { get; set; }
    
        public virtual GLOBALLOOKUP GLOBALLOOKUP { get; set; }
        public virtual GLOBALLOOKUP GLOBALLOOKUP1 { get; set; }
    }
}

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
    
    public partial class GLOBALLOOKUP
    {
        public GLOBALLOOKUP()
        {
            this.DOWNTIMEs = new HashSet<DOWNTIME>();
            this.DOWNTIMEs1 = new HashSet<DOWNTIME>();
        }
    
        public int LookupID { get; set; }
        public int LookupCat { get; set; }
        public string LookupDesc { get; set; }
    
        public virtual ICollection<DOWNTIME> DOWNTIMEs { get; set; }
        public virtual ICollection<DOWNTIME> DOWNTIMEs1 { get; set; }
        public virtual LOOKUPCATEGORY LOOKUPCATEGORY { get; set; }
    }
}
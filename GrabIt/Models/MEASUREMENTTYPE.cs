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
    
    public partial class MEASUREMENTTYPE
    {
        public MEASUREMENTTYPE()
        {
            this.MEASUREMENTLINKs = new HashSet<MEASUREMENTLINK>();
            this.MEASUREMENTS = new HashSet<MEASUREMENT>();
        }
    
        public int MeasurementTypeID { get; set; }
        public string Desc { get; set; }
        public int CategoryID { get; set; }
        public int ProcessTypeID { get; set; }
    
        public virtual CATEGORy CATEGORy { get; set; }
        public virtual ICollection<MEASUREMENTLINK> MEASUREMENTLINKs { get; set; }
        public virtual ICollection<MEASUREMENT> MEASUREMENTS { get; set; }
        public virtual PROCESSTYPE PROCESSTYPE { get; set; }
    }
}

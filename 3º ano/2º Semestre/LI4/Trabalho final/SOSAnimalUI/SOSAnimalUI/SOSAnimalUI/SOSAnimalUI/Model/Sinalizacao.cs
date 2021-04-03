using System;
using System.Collections.Generic;
using System.Spatial;
using System.Text;

namespace SOSAnimalUI.Model
{
    class Sinalizacao
    { 
        public int Id { get; set; }
        public int IdUser { get; set; }
        public System.DateTime Data { get; set; }
        public string Nota { get; set; }
        public string Status { get; set; }
        public Nullable<double> Lat { get; set; }
        public Nullable<double> Long { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Text;

namespace SOSAnimalUI.Model
{
    class Visita
    {
        public int Id { get; set; }
        public int IdUser { get; set; }
        public System.DateTime DataVisita { get; set; }
        public string Motivo { get; set; }
        public string Status { get; set; }

    }
}

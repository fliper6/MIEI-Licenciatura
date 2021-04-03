using System;
using System.Collections.Generic;
using System.Text;

namespace SOSAnimalUI.Model
{
     class Animal
    {
        public int Id { get; set; }
        public string Nome { get; set; }
        public string Especie { get; set; }
        public int Idade { get; set; }
        public double Peso { get; set; }
        public string HistoricoClinico { get; set; }
        public string Raca { get; set; }
        public int Status { get; set; }
    }
}

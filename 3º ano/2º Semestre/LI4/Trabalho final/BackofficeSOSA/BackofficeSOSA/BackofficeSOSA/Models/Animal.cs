using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BackofficeSOSA.Models
{
    public class Animal
    {
        public int Id { get; set; }

        [Required]
        [DataType(DataType.Text)]
        public string Nome { get; set; }

        [Required]
        [DataType(DataType.Text)]
        public string Especie { get; set; }

        [Required]
        public int Idade { get; set; }

        [Required]
        public double Peso { get; set; }

        [Required]
        [DataType(DataType.Text)]
        public string HistoricoClinico { get; set; }

        [Required]
        [DataType(DataType.Text)]
        public string Raca { get; set; }

        [Required]
        [Range(0, 1)]
        public int Status { get; set; }
    }
}
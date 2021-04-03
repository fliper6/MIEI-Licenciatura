using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BackofficeSOSA.Models
{
    public class Visita
    {
        public int Id { get; set; }

        [Required]
        public int IdUser { get; set; }

        [Required]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy H:mm:ss}")]
        [DataType(DataType.DateTime)]
        public System.DateTime DataVisita { get; set; }

        [Required]
        [DataType(DataType.Text)]
        public string Motivo { get; set; }

        [Required]
        [DataType(DataType.Text)]
        public string Status { get; set; }
    }
}
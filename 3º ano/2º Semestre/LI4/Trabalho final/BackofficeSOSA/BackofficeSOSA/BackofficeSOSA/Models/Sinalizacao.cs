using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BackofficeSOSA.Models
{
    public class Sinalizacao
    {
        public int Id { get; set; }

        [Required]
        public int IdUser { get; set; }

        [Required]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy H:mm:ss}")]
        [DataType(DataType.DateTime)]
        public System.DateTime Data { get; set; }

        [Required]
        [DataType(DataType.Text)]
        public string Nota { get; set; }

        [Required]
        [Range(0, 1)]
        public string Status { get; set; }

        [Required]
        public Nullable<double> Lat { get; set; }

        [Required]
        public Nullable<double> Long { get; set; }

    }
}
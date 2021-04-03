using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BackofficeSOSA.Models
{
    public class Adocao
    {
        public int Id { get; set; }

        [Required]
        public int IdUser { get; set; }

        [Required]
        public int IdAnimal { get; set; }

        [Required]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        [DataType(DataType.DateTime)]
        public System.DateTime Data { get; set; }
    }
}
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BackofficeSOSA.Models
{
    public class Utilizador
    {
        
        public int Id { get; set; }

        [Required]
        [DataType(DataType.Text)]
        public string Nome { get; set; }

        [Required]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Required]
        [DataType(DataType.PhoneNumber)]
        public int NrTelemovel { get; set; }
    }
}
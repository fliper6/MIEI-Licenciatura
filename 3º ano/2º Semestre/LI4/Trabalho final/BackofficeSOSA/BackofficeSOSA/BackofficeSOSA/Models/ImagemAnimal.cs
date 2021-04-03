using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BackofficeSOSA.Models
{
    public class ImagemAnimal
    {
        public int Id { get; set; }
        public int IdAnimal { get; set; }
        public byte[] img { get; set; }

    }
}
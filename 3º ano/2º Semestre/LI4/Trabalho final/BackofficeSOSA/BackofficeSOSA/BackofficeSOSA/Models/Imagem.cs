using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BackofficeSOSA.Models
{
    public class Imagem
    {
        public int Id { get; set; }
        public int IdSinalizacao { get; set; }
        public byte[] img { get; set; }
    }
}
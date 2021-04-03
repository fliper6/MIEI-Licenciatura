using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Xamarin.Forms;

namespace SOSAnimalUI.Model
{
    public class Empregado
    {
        [JsonProperty("FirstName")]
        public string Firstname { get; set; }

        [JsonProperty("Gender")]
        public string Gender { get; set; }

        [JsonProperty("ID")]
        public int Id { get; set; }

        [JsonProperty("LastName")]
        public string Lastname { get; set; }

        [JsonProperty("Salary")]
        public double Salary { get; set; }
  
    }
}
    

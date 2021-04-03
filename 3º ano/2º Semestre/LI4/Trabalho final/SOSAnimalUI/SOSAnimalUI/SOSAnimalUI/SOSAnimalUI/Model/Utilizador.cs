using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace SOSAnimalUI.Model
{
    class Utilizador
    {
        [JsonProperty("ID")]
        public int Id { get; set; }

        [JsonProperty("Nome")]
        public string Nome { get; set; }

        [JsonProperty("Email")]
        public string Email { get; set; }

        [JsonProperty("NrTelemovel")]
        public int NrTelemovel { get; set; }

        [JsonProperty("Password")]
        public string Password { get; set; }


    }
}

using Newtonsoft.Json;
using SOSAnimalUI.Helpers;
using SOSAnimalUI.Model;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace SOSAnimalUI.Services
{
    class ApiServices
    {
        private string APIURL = GlobalVars.apiurl;
        public async Task<bool> RegistarUtilizador(string nome, string email, string pw, string nrTele)
        {
            var client = new HttpClient();


            int.TryParse(nrTele, out int x);
            var model = new Utilizador
            {
                Nome = nome,
                Email = email,
                NrTelemovel = x,
                Password = pw
            };

            var json = JsonConvert.SerializeObject(model);

            HttpContent httpContent = new StringContent(json);

            httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

            var response = await client.PostAsync(APIURL + "/utilizador/Registar", httpContent);


            if (response.IsSuccessStatusCode)
            {                                                                                                                               
                return true;
            }

            return false;
        }

        public async Task<bool> Login(string email, string pw)
        {
            var client = new HttpClient();
            string str2;
            string str = APIURL + "/Utilizador/Login/" + email + "/" + pw+"/";
            var response = await client.GetAsync(str);//tento dar login na tabela utilizadores

            if (response.IsSuccessStatusCode)//se der o login é pq é um utilizador normal
            {
                str2 = APIURL + "/Utilizador/Em/" + email + "/";
                var response2 = await client.GetStringAsync(str2);
                GlobalVars.UserAtual = JsonConvert.DeserializeObject<Utilizador>(response2);
                GlobalVars.isEmpregadoLogged = false;
                return true;
            }
            string str1 = APIURL + "/Empregado/Login/" + email + "/" + pw+"/";
            var response1 = await client.GetAsync(str1);//se não der, tentamos dar login na tabela empregado

            if (response1.IsSuccessStatusCode) {
                str2 = APIURL + "/Empregado/Em/" + email + "/";
                var response2 = await client.GetStringAsync(str2);
                GlobalVars.EmpregadoAtual = JsonConvert.DeserializeObject<Empregado>(response2);
                GlobalVars.isEmpregadoLogged = true;
                return true;
            }

            return false;
        }

        public async Task<ObservableCollection<Sinalizacao>> GetHistoricoSins(int id)
        {
            var client = new HttpClient();
            var response = await client.GetStringAsync(APIURL + "/Sinalizacao/User/" + id+"/");
            var lista = JsonConvert.DeserializeObject<List<Sinalizacao>>(response);
            var col = new ObservableCollection<Sinalizacao>(lista);
            

            return col;
        }

        public async Task<ObservableCollection<Animal>> GetAnimais()
        {
            var client = new HttpClient();
            var response = await client.GetStringAsync(APIURL + "/Animal");
            var lista = JsonConvert.DeserializeObject<List<Animal>>(response);
            var col = new ObservableCollection<Animal>(lista);


            return col;
        }

        public async Task<bool> AtualizarUtilizador(Utilizador ut)
        {
            var client = new HttpClient();

            var json = JsonConvert.SerializeObject(ut);

            HttpContent httpContent = new StringContent(json);

            httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

            var response = await client.PutAsync(APIURL + "/utilizador/" + ut.Id, httpContent);


            if (response.IsSuccessStatusCode)
            {
                return true;
            }

            return false;
        }

        public async Task<bool> PushSinalizacao(Sinalizacao ut)
        {
            var client = new HttpClient();

            var json = JsonConvert.SerializeObject(ut);

            HttpContent httpContent = new StringContent(json);

            httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

            var response = await client.PostAsync(APIURL + "/sinalizacao", httpContent);


            if (response.IsSuccessStatusCode)
            {
                return true;
            }

            return false;

        }

        public async Task<bool> PushImagem(Imagem im)
        {
            var client = new HttpClient();

            var json = JsonConvert.SerializeObject(im);

            HttpContent httpContent = new StringContent(json);

            httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

            var response = await client.PostAsync(APIURL + "/imagem", httpContent);


            if (response.IsSuccessStatusCode)
            {
                return true;
            }

            return false;
        }

        public async Task<bool> PushVisita(Visita vis)
        {
            var client = new HttpClient();

            var json = JsonConvert.SerializeObject(vis);

            HttpContent httpContent = new StringContent(json);

            httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

            var response = await client.PostAsync(APIURL + "/visita", httpContent);


            if (response.IsSuccessStatusCode)
            {
                return true;
            }

            return false;
        }


        public async Task<int> GetSinalizacaoLastId(int i)
        {
            var client = new HttpClient();
            var response = await client.GetStringAsync(APIURL + "/Sinalizacao/LastId/"+i.ToString()+"/");
            var id = JsonConvert.DeserializeObject<int>(response);
            
            return id;
        }
        public async Task<ObservableCollection<Imagem>> GetImagens(int id)
        {
            var client = new HttpClient();
            var response = await client.GetStringAsync(APIURL + "/Imagem/Sin/"+id.ToString()+"/");
            var imgs = JsonConvert.DeserializeObject<ObservableCollection<Imagem>>(response);

            return imgs;
        }

        public async Task<ObservableCollection<ImagemAnimal>> GetImagensAnimais(int id)
        {
            var client = new HttpClient();
            var response = await client.GetStringAsync(APIURL + "/ImagemAnimal/Ani/" + id.ToString() + "/");
            var imgs = JsonConvert.DeserializeObject<ObservableCollection<ImagemAnimal>>(response);

            return imgs;
        }

        public async Task<ObservableCollection<Visita>> GetVisitas(int idu)
        {
            var client = new HttpClient();
            var response = await client.GetStringAsync(APIURL + "/Visita/Uti/"+idu+"/");
            var lista = JsonConvert.DeserializeObject<List<Visita>>(response);
            var vis = new ObservableCollection<Visita>(lista);

            return vis;
        }
    }
}

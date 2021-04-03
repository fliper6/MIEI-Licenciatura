using BackofficeSOSA.Helpers;
using BackofficeSOSA.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web;

namespace BackofficeSOSA.Services
{
    public class ApiServices
    {
        private string APIURL = GlobalVars.apiurl;

        public async Task<bool> Login(string email, string pw)
        {
            try
            {
                var client = new HttpClient();
            
                string str1 = APIURL + "/Empregado/Login/" + email + "/" + pw + "/";
                var response1 = await client.GetAsync(str1);

                if (response1.IsSuccessStatusCode)
                {
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        //-----------------------START Utilizador-----------------------

        public async Task<List<Utilizador>> GetUtilizadores()
        {
            try
            {
                var client = new HttpClient();
                var response = await client.GetStringAsync(APIURL + "/Utilizador");
                var lista = JsonConvert.DeserializeObject<List<Utilizador>>(response);
                var uts = new List<Utilizador>(lista);

                return uts;

            }catch (Exception ex)
            {
                throw ex;
            }
        }
        public async Task<Utilizador> GetUtilizador(int idUser)
        {

            try
            {
                var client = new HttpClient();
                string str = APIURL + "/Utilizador/ " + idUser + "/";
                var response = await client.GetStringAsync(str);
                Utilizador ut = JsonConvert.DeserializeObject<Utilizador>(response);

                return ut;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<Empregado> GetEmpregadoEmail(string email)
        {

            try
            {
                var client = new HttpClient();
                string str = APIURL + "/Empregado/em/" + email + "/";
                var response = await client.GetStringAsync(str);
                Empregado ut = JsonConvert.DeserializeObject<Empregado>(response);

                return ut;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public async Task<bool> DeleteUtilizador(int idUser)
        {
            try
            {
                var client = new HttpClient();
                string str = APIURL + "/Utilizador/" + idUser + "/";
                var response = await client.DeleteAsync(str);

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;

            }catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<bool> RegistarUtilizador(string nome, string email, string pw, int nrTele)
        {
            try
            {
                var client = new HttpClient();

            
                var model = new Utilizador
                {
                    Nome = nome,
                    Email = email,
                    NrTelemovel = nrTele,
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
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public async Task<bool> AtualizarUtilizador(Utilizador ut)
        {
            try
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
            catch (Exception ex)
            {
                throw ex;
            }

        }

        //-----------------------START Sinalização-----------------------

        public async Task<List<Sinalizacao>> GetSinalizacoes()
        {
            try
            {
                var client = new HttpClient();
                var response = await client.GetStringAsync(APIURL + "/Sinalizacao");
                var lista = JsonConvert.DeserializeObject<List<Sinalizacao>>(response);
                var sins = new List<Sinalizacao>(lista);


                return sins;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public async Task<Sinalizacao> GetSinalizacao(int idSin)
        {
            try
            {
                var client = new HttpClient();
                string str = APIURL + "/Sinalizacao/" + idSin + "/";
                var response = await client.GetStringAsync(str);
                Sinalizacao sin = JsonConvert.DeserializeObject<Sinalizacao>(response);

                return sin;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public async Task<bool> RegistarSinalizacao(Sinalizacao sin)
        {
            try
            {
                var client = new HttpClient();

                var json = JsonConvert.SerializeObject(sin);

                HttpContent httpContent = new StringContent(json);

                httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                var response = await client.PostAsync(APIURL + "/sinalizacao", httpContent);


                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public async Task<bool> AtualizarSinalizacao(Sinalizacao sin)
        {
            try
            {
                var client = new HttpClient();

                var json = JsonConvert.SerializeObject(sin);

                HttpContent httpContent = new StringContent(json);

                httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                var response = await client.PutAsync(APIURL + "/Sinalizacao/" + sin.Id, httpContent);


                if (response.IsSuccessStatusCode)
                {
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<bool> DeleteSinalizacao(int idSin)
        {
            try
            {
                var client = new HttpClient();
                string str = APIURL + "/Sinalizacao/" + idSin + "/";
                var response = await client.DeleteAsync(str);

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        //-----------------------START Empregado-----------------------

        public async Task<List<Empregado>> GetEmpregados()
        {
            try
            {
                var client = new HttpClient();
                var response = await client.GetStringAsync(APIURL + "/Empregado");
                var lista = JsonConvert.DeserializeObject<List<Empregado>>(response);
                var uts = new List<Empregado>(lista);

                return uts;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public async Task<Empregado> GetEmpregado(int id)
        {

            try
            {
                var client = new HttpClient();
                string str = APIURL + "/Empregado/ " + id + "/";
                var response = await client.GetStringAsync(str);
                Empregado ut = JsonConvert.DeserializeObject<Empregado>(response);

                return ut;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public async Task<bool> RegistarEmpregado(Empregado emp)
        {
            try
            {
                var client = new HttpClient();


                var json = JsonConvert.SerializeObject(emp);

                HttpContent httpContent = new StringContent(json);

                httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                var response = await client.PostAsync(APIURL + "/Empregado", httpContent);


                if (response.IsSuccessStatusCode)
                {
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public async Task<bool> AtualizarEmpregado(Empregado ut)
        {
            try
            {
                var client = new HttpClient();

                var json = JsonConvert.SerializeObject(ut);

                HttpContent httpContent = new StringContent(json);

                httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                var response = await client.PutAsync(APIURL + "/Empregado/" + ut.Id, httpContent);


                if (response.IsSuccessStatusCode)
                {
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public async Task<bool> DeleteEmpregado(int id)
        {
            try
            {
                var client = new HttpClient();
                string str = APIURL + "/Empregado/" + id + "/";
                var response = await client.DeleteAsync(str);

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //-----------------------START Adoção-----------------------

        public async Task<List<Adocao>> GetAdocoes()
        {
            try
            {
                var client = new HttpClient();
                var response = await client.GetStringAsync(APIURL + "/Adocao");
                var lista = JsonConvert.DeserializeObject<List<Adocao>>(response);
                var uts = new List<Adocao>(lista);

                return uts;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public async Task<Adocao> GetAdocao(int id)
        {

            try
            {
                var client = new HttpClient();
                string str = APIURL + "/Adocao/ " + id + "/";
                var response = await client.GetStringAsync(str);
                Adocao ut = JsonConvert.DeserializeObject<Adocao>(response);

                return ut;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public async Task<bool> RegistarAdocao(Adocao emp)
        {
            try
            {
                var client = new HttpClient();


                var json = JsonConvert.SerializeObject(emp);

                HttpContent httpContent = new StringContent(json);

                httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                var response = await client.PostAsync(APIURL + "/Adocao", httpContent);


                if (response.IsSuccessStatusCode)
                {
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public async Task<bool> AtualizarAdocao(Adocao ut)
        {
            try
            {
                var client = new HttpClient();

                var json = JsonConvert.SerializeObject(ut);

                HttpContent httpContent = new StringContent(json);

                httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                var response = await client.PutAsync(APIURL + "/Adocao/" + ut.Id, httpContent);


                if (response.IsSuccessStatusCode)
                {
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public async Task<bool> DeleteAdocao(int id)
        {
            try
            {
                var client = new HttpClient();
                string str = APIURL + "/Adocao/" + id + "/";
                var response = await client.DeleteAsync(str);

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //-----------------------START Visita-----------------------

        public async Task<List<Visita>> GetVisitas()
        {
            try
            {
                var client = new HttpClient();
                var response = await client.GetStringAsync(APIURL + "/Visita");
                var lista = JsonConvert.DeserializeObject<List<Visita>>(response);
                var uts = new List<Visita>(lista);

                return uts;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public async Task<Visita> GetVisita(int id)
        {

            try
            {
                var client = new HttpClient();
                string str = APIURL + "/Visita/ " + id + "/";
                var response = await client.GetStringAsync(str);
                Visita ut = JsonConvert.DeserializeObject<Visita>(response);

                return ut;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public async Task<bool> RegistarVisita(Visita emp)
        {
            try
            {
                var client = new HttpClient();


                var json = JsonConvert.SerializeObject(emp);

                HttpContent httpContent = new StringContent(json);

                httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                var response = await client.PostAsync(APIURL + "/Visita", httpContent);


                if (response.IsSuccessStatusCode)
                {
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public async Task<bool> AtualizarVisita(Visita ut)
        {
            try
            {
                var client = new HttpClient();

                var json = JsonConvert.SerializeObject(ut);

                HttpContent httpContent = new StringContent(json);

                httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                var response = await client.PutAsync(APIURL + "/Visita/" + ut.Id, httpContent);


                if (response.IsSuccessStatusCode)
                {
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public async Task<bool> DeleteVisita(int id)
        {
            try
            {
                var client = new HttpClient();
                string str = APIURL + "/Visita/" + id + "/";
                var response = await client.DeleteAsync(str);

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //-----------------------START Animal-----------------------

        public async Task<List<Animal>> GetAnimais()
        {
            try
            {
                var client = new HttpClient();
                var response = await client.GetStringAsync(APIURL + "/Animal");
                var lista = JsonConvert.DeserializeObject<List<Animal>>(response);
                var uts = new List<Animal>(lista);

                return uts;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public async Task<Animal> GetAnimal(int id)
        {

            try
            {
                var client = new HttpClient();
                string str = APIURL + "/Animal/ " + id + "/";
                var response = await client.GetStringAsync(str);
                Animal ut = JsonConvert.DeserializeObject<Animal>(response);

                return ut;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public async Task<bool> RegistarAnimal(Animal emp)
        {
            try
            {
                var client = new HttpClient();


                var json = JsonConvert.SerializeObject(emp);

                HttpContent httpContent = new StringContent(json);

                httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                var response = await client.PostAsync(APIURL + "/Animal", httpContent);


                if (response.IsSuccessStatusCode)
                {
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public async Task<bool> AtualizarAnimal(Animal ut)
        {
            try
            {
                var client = new HttpClient();

                var json = JsonConvert.SerializeObject(ut);

                HttpContent httpContent = new StringContent(json);

                httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                var response = await client.PutAsync(APIURL + "/Animal/" + ut.Id, httpContent);


                if (response.IsSuccessStatusCode)
                {
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public async Task<bool> DeleteAnimal(int id)
        {
            try
            {
                var client = new HttpClient();
                string str = APIURL + "/Animal/" + id + "/";
                var response = await client.DeleteAsync(str);

                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                return false;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<List<String>> GetImagens(int id)
        {
            var client = new HttpClient();
            var response = await client.GetStringAsync(APIURL + "/Imagem/Sin/" + id.ToString() + "/");
            var imgs = JsonConvert.DeserializeObject<List<Imagem>>(response);

            List<String> imgsString = new List<string>();
            foreach (Imagem i in imgs)
            {
                string imreBase64Data = Convert.ToBase64String(i.img);
                string imgDataURL = string.Format("data:image/png;base64,{0}", imreBase64Data);
                imgsString.Add(imgDataURL);
            }
            return imgsString;
        }
        public async Task<bool> RegistarImagem(Imagem im)
        {
            try
            {
                var client = new HttpClient();


                var json = JsonConvert.SerializeObject(im);

                HttpContent httpContent = new StringContent(json);

                httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                var response = await client.PostAsync(APIURL + "/Imagem", httpContent);


                if (response.IsSuccessStatusCode)
                {
                    return true;
                }
                
                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public async Task<List<String>> GetImagensAnimais(int id)
        {
            var client = new HttpClient();
            var response = await client.GetStringAsync(APIURL + "/ImagemAnimal/Ani/" + id.ToString() + "/");
            var imgs = JsonConvert.DeserializeObject<List<ImagemAnimal>>(response);

            List<String> imgsString = new List<string>();
            foreach (ImagemAnimal i in imgs)
            {
                string imreBase64Data = Convert.ToBase64String(i.img);
                string imgDataURL = string.Format("data:image/png;base64,{0}", imreBase64Data);
                imgsString.Add(imgDataURL);
            }
            return imgsString;
        }
        public async Task<bool> RegistarImagemAnimal(ImagemAnimal im)
        {
            try
            {
                var client = new HttpClient();


                var json = JsonConvert.SerializeObject(im);

                HttpContent httpContent = new StringContent(json);

                httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

                var response = await client.PostAsync(APIURL + "/ImagemAnimal", httpContent);


                if (response.IsSuccessStatusCode)
                {
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        /* private string APIURL = GlobalVars.apiurl;
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

        public async Task<ObservableCollection<Visita>> GetVisitas(int idu)
        {
            var client = new HttpClient();
            var response = await client.GetStringAsync(APIURL + "/Visita/Uti/"+idu+"/");
            var lista = JsonConvert.DeserializeObject<List<Visita>>(response);
            var vis = new ObservableCollection<Visita>(lista);

            return vis;
        }*/
    }
}
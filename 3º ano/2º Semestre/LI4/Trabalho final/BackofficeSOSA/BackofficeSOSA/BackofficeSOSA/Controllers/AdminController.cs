using BackofficeSOSA.Models;
using BackofficeSOSA.Services;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Razor.Generator;

namespace BackofficeSOSA.Controllers
{
    [Authorize]
    public class AdminController : Controller
    {
        private ApiServices apiServices = new ApiServices();

       
        public ActionResult Dashboard()
        {
            return View();
        }

        public async Task<ActionResult> Perfil()
        {
            Empregado ut = await apiServices.GetEmpregadoEmail(@User.Identity.Name.ToString());
            return RedirectToAction("DetailsEmpregado/"+ut.Id);
        }
        //-----------------------START UTILIZADOR-----------------------
        public async Task<ActionResult> Utilizadores()
        {
            List<Utilizador> uts = await apiServices.GetUtilizadores();
            return View(uts);
        }

        public ActionResult AddUtilizador()
        {
            return View();
        }

        //AddUtilizador
        [HttpPost]
        public async Task<ActionResult> AddUtilizador(Utilizador ut)
        {
            bool isAdded = await apiServices.RegistarUtilizador(ut.Nome, ut.Email, ut.Password, ut.NrTelemovel);

            if (isAdded)
            {
                TempData["Success"] = "Utilizador adicionado com sucesso!";
                return RedirectToAction("Utilizadores");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Dados incorretos.");
                return View(ut);
            }
        }

        public async Task<ActionResult> EditUtilizador(int Id)
        {
            Utilizador ut = await apiServices.GetUtilizador(Id);
            return View(ut);
        }

        //EditUtilizador
        [HttpPost]
        public async Task<ActionResult> EditUtilizador(Utilizador ut)
        {
            bool isUpdated = await apiServices.AtualizarUtilizador(ut);

            if (isUpdated)
            {
                TempData["Success"] = "Utilizador atualizado com sucesso!";
                return RedirectToAction("Utilizadores");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Dados incorretos.");
                return View(ut);
            }
        }

        public async Task<ActionResult> DetailsUtilizador(int Id)
        {
            Utilizador ut = await apiServices.GetUtilizador(Id);
            return View(ut);
        }

        public async Task<ActionResult> DeleteUtilizador(int Id)
        {
            Utilizador ut = await apiServices.GetUtilizador(Id);
            return View(ut);
        }

        //DeleteUtilizador
        [HttpPost]
        public async Task<ActionResult> DeleteUtilizador(Utilizador ut)
        {
            bool isDeleted = await apiServices.DeleteUtilizador(ut.Id);

            if (isDeleted)
            {
                TempData["Success"] = "Utilizador removido com sucesso!";
                return RedirectToAction("Utilizadores");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Ocorreu um erro!.");
                return View(ut);
            }
        }


        //-----------------------START Sinalizacao-----------------------
        public async Task<ActionResult> Sinalizacoes()
        {
            Response.AddHeader("Refresh", "25");
            List<Sinalizacao> sins = await apiServices.GetSinalizacoes();
            return View(sins);
        }

        public ActionResult AddSinalizacao()
        {
            return View();
        }

        //AddSinalizacao
        [HttpPost]
        public async Task<ActionResult> AddSinalizacao(Sinalizacao sin)
        {
            bool isAdded = await apiServices.RegistarSinalizacao(sin);

            if (isAdded)
            {
                TempData["Success"] = "Sinalização adicionado com sucesso!";
                return RedirectToAction("Sinalizacoes");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Dados incorretos.");
                return View(sin);
            }
        }

        public async Task<ActionResult> EditSinalizacao(int Id)
        {
            Sinalizacao sin = await apiServices.GetSinalizacao(Id);
            return View(sin);
        }

        //EditSinalizacao
        [HttpPost]
        public async Task<ActionResult> EditSinalizacao(Sinalizacao sin)
        {
            bool isUpdated = await apiServices.AtualizarSinalizacao(sin);

            if (isUpdated)
            {
                TempData["Success"] = "Sinalização atualizado com sucesso!";
                return RedirectToAction("Sinalizacoes");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Dados incorretos.");
                return View(sin);
            }
        }

        public async Task<ActionResult> DetailsSinalizacao(int Id)
        {
            List<String> imgsString = await apiServices.GetImagens(Id);
            
            ViewData["imagens"] = imgsString;
            Sinalizacao sin = await apiServices.GetSinalizacao(Id);
            return View(sin);
        }

        public async Task<ActionResult> DeleteSinalizacao(int Id)
        {
            Sinalizacao sin = await apiServices.GetSinalizacao(Id);
            return View(sin);
        }

        //DeleteSinalizacao
        [HttpPost]
        public async Task<ActionResult> DeleteSinalizacao(Sinalizacao sin)
        {
            bool isDeleted = await apiServices.DeleteSinalizacao(sin.Id);

            if (isDeleted)
            {
                TempData["Success"] = "Sinalização removida com sucesso!";
                return RedirectToAction("Sinalizacoes");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Ocorreu um erro!.");
                return View(sin);
            }
        }

        //-----------------------START Empregado-----------------------
        public async Task<ActionResult> Empregados()
        {
            List<Empregado> uts = await apiServices.GetEmpregados();
            return View(uts);
        }

        public ActionResult AddEmpregado()
        {
            return View();
        }

        //AddEmpregado
        [HttpPost]
        public async Task<ActionResult> AddEmpregado(Empregado emp)
        {
            bool isAdded = await apiServices.RegistarEmpregado(emp);

            if (isAdded)
            {
                TempData["Success"] = "Empregado adicionado com sucesso!";
                return RedirectToAction("Empregados");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Dados incorretos.");
                return View(emp);
            }
        }

        public async Task<ActionResult> EditEmpregado(int Id)
        {
            Empregado ut = await apiServices.GetEmpregado(Id);
            return View(ut);
        }

        //EditEmpregado
        [HttpPost]
        public async Task<ActionResult> EditEmpregado(Empregado ut)
        {
            bool isUpdated = await apiServices.AtualizarEmpregado(ut);

            if (isUpdated)
            {
                TempData["Success"] = "Empregado atualizado com sucesso!";
                return RedirectToAction("Empregados");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Dados incorretos.");
                return View(ut);
            }
        }

        public async Task<ActionResult> DetailsEmpregado(int Id)
        {
            Empregado ut = await apiServices.GetEmpregado(Id);
            return View(ut);
        }

        public async Task<ActionResult> DeleteEmpregado(int Id)
        {
            Empregado ut = await apiServices.GetEmpregado(Id);
            return View(ut);
        }

        //DeleteEmpregado
        [HttpPost]
        public async Task<ActionResult> DeleteEmpregado(Empregado ut)
        {
            bool isDeleted = await apiServices.DeleteEmpregado(ut.Id);

            if (isDeleted)
            {
                TempData["Success"] = "Empregado removido com sucesso!";
                return RedirectToAction("Empregados");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Ocorreu um erro!.");
                return View(ut);
            }
        }

        //-----------------------START Adocao-----------------------
        public async Task<ActionResult> Adocoes()
        {
            List<Adocao> uts = await apiServices.GetAdocoes();
            return View(uts);
        }

        public ActionResult AddAdocao()
        {
            return View();
        }

        //AddAdocao
        [HttpPost]
        public async Task<ActionResult> AddAdocao(Adocao emp)
        {
            bool isAdded = await apiServices.RegistarAdocao(emp);

            if (isAdded)
            {
                TempData["Success"] = "Adoção adicionada com sucesso!";
                return RedirectToAction("Adocoes");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Dados incorretos.");
                return View(emp);
            }
        }

        public async Task<ActionResult> EditAdocao(int Id)
        {
            Adocao ut = await apiServices.GetAdocao(Id);
            return View(ut);
        }

        //EditAdocao
        [HttpPost]
        public async Task<ActionResult> EditAdocao(Adocao ut)
        {
            bool isUpdated = await apiServices.AtualizarAdocao(ut);

            if (isUpdated)
            {
                TempData["Success"] = "Adoção atualizada com sucesso!";
                return RedirectToAction("Adocoes");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Dados incorretos.");
                return View(ut);
            }
        }

        public async Task<ActionResult> DetailsAdocao(int Id)
        {
            Adocao ut = await apiServices.GetAdocao(Id);
            return View(ut);
        }

        public async Task<ActionResult> DeleteAdocao(int Id)
        {
            Adocao ut = await apiServices.GetAdocao(Id);
            return View(ut);
        }

        //DeleteAdocao
        [HttpPost]
        public async Task<ActionResult> DeleteAdocao(Adocao ut)
        {
            bool isDeleted = await apiServices.DeleteAdocao(ut.Id);

            if (isDeleted)
            {
                TempData["Success"] = "Adoção removida com sucesso!";
                return RedirectToAction("Adocoes");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Ocorreu um erro!.");
                return View(ut);
            }
        }

        //-----------------------START Visita-----------------------
        public async Task<ActionResult> Visitas()
        {
            List<Visita> uts = await apiServices.GetVisitas();
            return View(uts);
        }

        public ActionResult AddVisita()
        {
            return View();
        }

        //AddVisita
        [HttpPost]
        public async Task<ActionResult> AddVisita(Visita emp)
        {
            bool isAdded = await apiServices.RegistarVisita(emp);

            if (isAdded)
            {
                TempData["Success"] = "Visita adicionada com sucesso!";
                return RedirectToAction("Visitas");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Dados incorretos.");
                return View(emp);
            }
        }

        public async Task<ActionResult> EditVisita(int Id)
        {
            Visita ut = await apiServices.GetVisita(Id);
            return View(ut);
        }

        //EditVisita
        [HttpPost]
        public async Task<ActionResult> EditVisita(Visita ut)
        {
            bool isUpdated = await apiServices.AtualizarVisita(ut);

            if (isUpdated)
            {
                TempData["Success"] = "Visita atualizada com sucesso!";
                return RedirectToAction("Visitas");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Dados incorretos.");
                return View(ut);
            }
        }

        public async Task<ActionResult> DetailsVisita(int Id)
        {
            Visita ut = await apiServices.GetVisita(Id);
            return View(ut);
        }

        public async Task<ActionResult> DeleteVisita(int Id)
        {
            Visita ut = await apiServices.GetVisita(Id);
            return View(ut);
        }

        //DeleteVisita
        [HttpPost]
        public async Task<ActionResult> DeleteVisita(Visita ut)
        {
            bool isDeleted = await apiServices.DeleteVisita(ut.Id);

            if (isDeleted)
            {
                TempData["Success"] = "Visita removida com sucesso!";
                return RedirectToAction("Visitas");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Ocorreu um erro!.");
                return View(ut);
            }
        }

        //-----------------------START Animais-----------------------
        public async Task<ActionResult> Animais()
        {
            List<Animal> uts = await apiServices.GetAnimais();
            return View(uts);
        }

        public ActionResult AddAnimal()
        {
            return View();
        }

        //AddAnimal
        [HttpPost]
        public async Task<ActionResult> AddAnimal(Animal emp)
        {
            bool isAdded = await apiServices.RegistarAnimal(emp);

            if (isAdded)
            {
                TempData["Success"] = "Animal adicionada com sucesso!";
                return RedirectToAction("Animais");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Dados incorretos.");
                return View(emp);
            }
        }

        public async Task<ActionResult> EditAnimal(int Id)
        {
            Animal ut = await apiServices.GetAnimal(Id);
            return View(ut);
        }

        //EditAnimal
        [HttpPost]
        public async Task<ActionResult> EditAnimal(Animal ut)
        {
            bool isUpdated = await apiServices.AtualizarAnimal(ut);

            if (isUpdated)
            {
                TempData["Success"] = "Animal atualizado com sucesso!";
                return RedirectToAction("Animais");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Dados incorretos.");
                return View(ut);
            }
        }

        public async Task<ActionResult> DetailsAnimal(int Id)
        {
            List<String> imgsString = await apiServices.GetImagensAnimais(Id);

            ViewData["imagensAni"] = imgsString;
            Animal ut = await apiServices.GetAnimal(Id);
            return View(ut);
        }

        public async Task<ActionResult> DeleteAnimal(int Id)
        {
            Animal ut = await apiServices.GetAnimal(Id);
            return View(ut);
        }

        //DeleteAnimal
        [HttpPost]
        public async Task<ActionResult> DeleteAnimal(Animal ut)
        {
            bool isDeleted = await apiServices.DeleteAnimal(ut.Id);

            if (isDeleted)
            {
                TempData["Success"] = "Animal removido com sucesso!";
                return RedirectToAction("Animais");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Ocorreu um erro!.");
                return View(ut);
            }
        }
        //-----------------------START ImagemSin-----------------------

        public ActionResult AddImagem(int Id)
        {

            TempData["idsin"] = Id;

            return View();
        }

        //AddImagem
        [HttpPost]
        public async Task<ActionResult> AddImagem(HttpPostedFileBase postedFile)
        {
            byte[] bytes;
            BinaryReader br = new BinaryReader(postedFile.InputStream);

            bytes = br.ReadBytes(postedFile.ContentLength);

            Imagem im = new Imagem
            {
                IdSinalizacao = (int)TempData["idsin"],
                img = bytes
            };

            bool isAdded = await apiServices.RegistarImagem(im);

            if (isAdded)
            {
                TempData["Success"] = "Imagem adicionada com sucesso!";
                return RedirectToAction("Sinalizacoes");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Dados incorretos.");
                return View(im);
            }
        }
            //-----------------------START ImagemAnimal-----------------------

        public ActionResult AddImagemAnimal(int Id)
        {

            TempData["idAni"] = Id;

            return View();
        }

        //AddImagemAnimal
        [HttpPost]
        public async Task<ActionResult> AddImagemAnimal(HttpPostedFileBase postedFile)
        {
            byte[] bytes;
            BinaryReader br = new BinaryReader(postedFile.InputStream);

            bytes = br.ReadBytes(postedFile.ContentLength);

            ImagemAnimal im = new ImagemAnimal
            {
                IdAnimal = (int)TempData["idAni"],
                img = bytes
            };

            bool isAdded = await apiServices.RegistarImagemAnimal(im);

            if (isAdded)
            {
                TempData["Success"] = "Imagem do animal adicionada com sucesso!";
                return RedirectToAction("Animais");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Dados incorretos.");
                return View(im);
            }
        }
    }
}
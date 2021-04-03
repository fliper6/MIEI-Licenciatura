using SOSAnimalUI.Helpers;
using SOSAnimalUI.Model;
using SOSAnimalUI.Services;
using SOSAnimalUI.Views;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using Xamarin.Forms;

namespace SOSAnimalUI.ViewModel
{
    class EditarNomeViewModel
    {

        ApiServices apiServices = new ApiServices();
        public string Nome { get; set; }
        public string Password { get; set; }
        public bool IsClicked { get; set; }
        public ICommand GuardarCommand
        {
            get
            {
                return new Command(async () =>
                {
                    while (IsClicked)
                    {
                        await Task.Delay(25);
                    }

                    IsClicked = true;

                    Utilizador ut = GlobalVars.GetUt();

                    if (string.IsNullOrWhiteSpace(Nome) || string.IsNullOrWhiteSpace(Password) || Nome.Equals(ut.Nome))
                    {
                        await Application.Current.MainPage.DisplayAlert("Erro!", "Dados inválidos!", "OK");
                        IsClicked = false;
                        return;
                    }
                    else if (!Password.Equals(GlobalVars.UserAtual.Password))
                    {
                        await Application.Current.MainPage.DisplayAlert("Erro!", "Password inválida!", "OK");
                        IsClicked = false;
                        return;
                    }

                    ut.Nome = Nome;
                    var isGuardado = await apiServices.AtualizarUtilizador(ut);

                    if (isGuardado)
                    {
                        await Application.Current.MainPage.DisplayAlert("Atualização completa!", "O seu nome foi atualizado com sucesso!", "OK");
                        GlobalVars.UserAtual.Nome = Nome;
                        Application.Current.MainPage = new Perfil();
                        IsClicked = false;
                        return;
                    }
                    else
                    {
                        await Application.Current.MainPage.DisplayAlert("Atualização falhada!", "Erro na atualização", "OK");
                        Application.Current.MainPage = new Perfil();
                        IsClicked = false;
                        return;
                    }
                });
            }
        }
    }
}


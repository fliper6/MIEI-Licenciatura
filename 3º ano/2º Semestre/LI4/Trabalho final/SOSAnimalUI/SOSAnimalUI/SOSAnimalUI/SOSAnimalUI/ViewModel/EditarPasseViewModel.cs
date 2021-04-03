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
    class EditarPasseViewModel
    {
        ApiServices apiServices = new ApiServices();
        public string PasswordAtual { get; set; }
        public string NovaPassword { get; set; }
        public string CofNovaPassword { get; set; }
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

                    if (string.IsNullOrWhiteSpace(PasswordAtual) || string.IsNullOrWhiteSpace(NovaPassword) || string.IsNullOrWhiteSpace(CofNovaPassword) || !NovaPassword.Equals(CofNovaPassword))
                    {
                        await Application.Current.MainPage.DisplayAlert("Erro!", "Dados inválidos!", "OK");
                        IsClicked = false;
                        return;
                    }
                    else if (!PasswordAtual.Equals(GlobalVars.UserAtual.Password))
                    {
                        await Application.Current.MainPage.DisplayAlert("Erro!", "Password atual inválida!", "OK");
                        IsClicked = false;
                        return;
                    }

                    ut.Password = NovaPassword;

                    var isGuardado = await apiServices.AtualizarUtilizador(ut);

                    if (isGuardado)
                    {
                        await Application.Current.MainPage.DisplayAlert("Atualização completa!", "A sua passe foi atualizada com sucesso!", "OK");
                        GlobalVars.UserAtual.Password = NovaPassword;
                        Application.Current.MainPage = new Perfil();
                        IsClicked = false;
                        return;
                    }
                    else
                    {
                        await Application.Current.MainPage.DisplayAlert("Atualização falhada!", "Erro na atualização da passe", "OK");
                        Application.Current.MainPage = new Perfil();
                        IsClicked = false;
                        return;
                    }
                });
            }
        }
    }

}


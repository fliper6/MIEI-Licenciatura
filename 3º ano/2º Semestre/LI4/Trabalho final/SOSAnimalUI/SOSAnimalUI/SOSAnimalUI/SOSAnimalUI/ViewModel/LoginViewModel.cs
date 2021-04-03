using SOSAnimalUI.Helpers;
using SOSAnimalUI.Services;
using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Input;
using Xamarin.Forms;

namespace SOSAnimalUI.ViewModel
{
    class LoginViewModel
    {
        ApiServices apiServices = new ApiServices();
        public string Email { get; set; }
        public string Password { get; set; }

        public ICommand LoginCommand
        {
            get
            {
                return new Command(async () =>
                {
                    if (string.IsNullOrWhiteSpace(Email) || string.IsNullOrWhiteSpace(Password))
                    {
                        await Application.Current.MainPage.DisplayAlert("Erro!", "Insira os dados!", "OK");
                        return;
                    }

                    var isLogged = await apiServices.Login(Email,Password);

                    if (isLogged)
                    {
                        await Application.Current.MainPage.DisplayAlert("Login completo!", "Foi logado com sucesso!", "OK");
                        Application.Current.MainPage = new MainPage();
                        return;
                    }
                    else
                    {
                        await Application.Current.MainPage.DisplayAlert("Erro no login!", "Informação incorreta, tente novamente!", "OK");
                        return;
                    }
                });
            }
        }
    }
}

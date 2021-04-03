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
    class RegistarViewModel
    {
        ApiServices apiServices = new ApiServices();
        public string Nome { get; set; }
        public string Email { get; set; }
        public string NrTele { get; set; }
        public string Password { get; set; }
        public string CofPassword { get; set; }

        public bool IsClicked { get; set; }

        public ICommand RegistarCommand
        {
            get
            {
                return  new Command(async () => 
                {
                    while (IsClicked)
                    {
                        await Task.Delay(25);
                    }

                    IsClicked = true;

                    if (string.IsNullOrWhiteSpace(Nome) || string.IsNullOrWhiteSpace(Email) || string.IsNullOrWhiteSpace(NrTele) || string.IsNullOrWhiteSpace(Password) || string.IsNullOrWhiteSpace(CofPassword) || !Password.Equals(CofPassword)) 
                    {
                        await Application.Current.MainPage.DisplayAlert("Erro!", "Dados incorretos!", "OK");
                        IsClicked = false;
                        return;
                    }
                   
                    var isRegistado = await apiServices.RegistarUtilizador(Nome,Email,Password,NrTele);

                    if (isRegistado)
                    {
                        await Application.Current.MainPage.DisplayAlert("Registo completo!", "Foi registado com sucesso!", "OK");
                        Application.Current.MainPage = new Login();
                        IsClicked = false;
                        return;
                    }
                    else
                    {
                        await Application.Current.MainPage.DisplayAlert("Erro no registo!", "Tente registar-se novamente!", "OK");
                        IsClicked = false;
                        return;
                    }
                });
            }
        }

    }
}

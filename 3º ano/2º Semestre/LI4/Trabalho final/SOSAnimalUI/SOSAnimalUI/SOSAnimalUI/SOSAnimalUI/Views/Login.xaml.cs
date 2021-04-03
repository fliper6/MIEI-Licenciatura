using SOSAnimalUI.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace SOSAnimalUI.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class Login : ContentPage
    {
        LoginViewModel lvm;
        public Login()
        {
            
            InitializeComponent();
            BindingContext = lvm = new LoginViewModel();
        }


        private void Registar_Clicked(object sender, EventArgs e)
        {
            Application.Current.MainPage = new Registar();
        }

        private void Emergencia_Clicked(object sender, EventArgs e)
        {
            Application.Current.MainPage = new NavigationPage(new Sinalizar(true));

        }
    }
}
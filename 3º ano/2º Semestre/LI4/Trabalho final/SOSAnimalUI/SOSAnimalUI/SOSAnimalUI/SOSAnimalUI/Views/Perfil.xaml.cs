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
    public partial class Perfil : ContentPage
    {
        public Perfil()
        {
            InitializeComponent();
            BindingContext = new PerfilViewModel();
        }

        private void Clicked_BackPerfil(object sender, EventArgs e)
        {
            Application.Current.MainPage = new MainPage();
        }

        private void Clicked_Editar_Nome(object sender, EventArgs e)
        {
            Application.Current.MainPage = new Editar_Nome();
        }

        private void Clicked_Editar_Passe(object sender, EventArgs e)
        {
            Application.Current.MainPage = new Editar_Passe();
        }

        private void Clicked_Historico(object sender, EventArgs e)
        {
            Application.Current.MainPage = new Historico(1);
        }
    }
}
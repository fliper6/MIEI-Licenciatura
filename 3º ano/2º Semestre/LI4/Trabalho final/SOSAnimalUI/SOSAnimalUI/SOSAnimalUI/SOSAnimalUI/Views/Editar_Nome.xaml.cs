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
    public partial class Editar_Nome : ContentPage
    {
        public Editar_Nome()
        {
            InitializeComponent();
            BindingContext = new EditarNomeViewModel();
        }

        private void Clicked_BackEditarN(object sender, EventArgs e)
        {
            Application.Current.MainPage = new Perfil();
        }
    }
}
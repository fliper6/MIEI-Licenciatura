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
    public partial class Editar_Passe : ContentPage
    {
        public Editar_Passe()
        {
            InitializeComponent();
            BindingContext = new EditarPasseViewModel();
        }

        private void Clicked_BackEditarP(object sender, EventArgs e)
        {
            Application.Current.MainPage = new Perfil();
        }

    
    }
}
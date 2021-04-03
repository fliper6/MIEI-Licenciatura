using SOSAnimalUI.Model;
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
    public partial class Animais : ContentPage
    {
        public Animais()
        {
            InitializeComponent();
            BindingContext = new AnimaisViewModel();
        }

        private void Clicked_BackAnimais(object sender, EventArgs e)
        {
            Application.Current.MainPage = new MainPage();
        }

        private void OnItemSelected(Object sender, ItemTappedEventArgs e)
        {
            var mydetails = e.Item as Animal;
            Application.Current.MainPage = new AnimaisDetails(mydetails.Id,mydetails.Nome, mydetails.Especie, mydetails.Peso, mydetails.HistoricoClinico,mydetails.Raca,mydetails.Status);

        }
    }
}
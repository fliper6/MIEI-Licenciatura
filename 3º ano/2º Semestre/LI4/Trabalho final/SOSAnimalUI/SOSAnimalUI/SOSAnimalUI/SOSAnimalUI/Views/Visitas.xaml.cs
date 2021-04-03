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
    public partial class Visitas : ContentPage
    {
        public Visitas()
        {
            InitializeComponent();
            BindingContext = new VisitasViewModel();
        }
        private void Clicked_BackAnimais(object sender, EventArgs e)
        {
            Application.Current.MainPage = new MainPage();
        }

        private void OnItemSelected(Object sender, ItemTappedEventArgs e)
        {
            var mydetails = e.Item as Visita;
            Application.Current.MainPage = new VisitaDetail(mydetails.DataVisita, mydetails.Motivo, mydetails.Status);

        }
    }
}

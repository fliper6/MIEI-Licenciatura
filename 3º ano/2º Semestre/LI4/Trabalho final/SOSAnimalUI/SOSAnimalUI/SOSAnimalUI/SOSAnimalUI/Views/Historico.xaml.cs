using Newtonsoft.Json;
using SOSAnimalUI.Model;
using SOSAnimalUI.ViewModel;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace SOSAnimalUI.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class Historico : ContentPage
    {
        private int origem;
        public Historico(int origem)
        {
            InitializeComponent();
            this.origem = origem;
            BindingContext  = new HistoricoViewModel();
           
            
        }
        private void Clicked_BackHistorico(object sender, EventArgs e)
        {
            if (origem == 0)
                Application.Current.MainPage = new MainPage();
            else
                Application.Current.MainPage = new Perfil();
        }

        private void OnItemSelected(Object sender, ItemTappedEventArgs e)
        {
            var mydetails = e.Item as Sinalizacao;
            Application.Current.MainPage = new HistoricoDetails(mydetails.Id,mydetails.Data, mydetails.Nota, mydetails.Lat, mydetails.Long, this.origem);

        }

    }
}
using SOSAnimalUI.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Essentials;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace SOSAnimalUI.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class HistoricoDetails : ContentPage
    {
        private int origem;

        public HistoricoDetails(int id,DateTime dat, string not, double? lati, double? longe, int origem)
        {
            InitializeComponent();
            BindingContext = new HistoricoDetailsViewModel(id);
            this.origem = origem;
            note.Text =  not;
            data.Text = dat.ToString();

            getAddrsAsync(lati.Value, longe.Value);
        }

       
        private async void getAddrsAsync(double lati, double longe)
        {
            try
            {
                var addrs = (await Geocoding.GetPlacemarksAsync(new Location(lati, longe))).FirstOrDefault();

                Street.Text = $"{addrs.Thoroughfare} {addrs.SubThoroughfare}";
                City.Text = $"{addrs.PostalCode} {addrs.Locality}";
                Country.Text =  addrs.CountryName;

            }
            catch (Exception ex)
            {
                await Application.Current.MainPage.DisplayAlert("Error", ex.Message, "OK");

            }
        }

        private void Clicked_BackHDetails(object sender, EventArgs e)
        {
            Application.Current.MainPage = new Historico(origem);
        }
    }
}
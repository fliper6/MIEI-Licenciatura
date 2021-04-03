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
    public partial class AnimaisDetails : ContentPage
    {
        public AnimaisDetails(int id,string Nome ,string Especie ,double Peso ,string HistoricoClinico ,string Raca ,int Status)
        {
            InitializeComponent();
            BindingContext = new AnimaisDetailsViewModel(id);

            nome.Text = Nome;
            espec.Text = Especie;
            raca.Text = Raca;
            peso.Text = Peso.ToString();
            if (Status == 1) { stat.Text = "No estabelecimento."; }
            else { stat.Text = "Em tratamento."; }
            historic.Text = HistoricoClinico;
        }

        private void Clicked_BackHDetails(object sender, EventArgs e)
        {
            Application.Current.MainPage = new Animais();
        }
    }
}
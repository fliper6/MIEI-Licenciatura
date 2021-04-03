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
    public partial class VisitaDetail : ContentPage
    {
        public VisitaDetail(DateTime dataVisita, string motivo, string status)
        {
            InitializeComponent();
            dat.Text = dataVisita.ToString();
            moti.Text = motivo;
            if (status == "W") { stat.Text = "Pedido de visita a ser processado!"; }
            else if (status == "A") { stat.Text = "Visita marcada!"; }
            else { stat.Text = "Visita cancelada!"; }
        }

   
        private void Clicked_BackHDetails(object sender, EventArgs e)
        {
            Application.Current.MainPage = new Visitas();
        }
    }
}
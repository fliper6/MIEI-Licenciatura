using Newtonsoft.Json;
using SOSAnimalUI.Model;
using SOSAnimalUI.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace SOSAnimalUI.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class Registar : ContentPage
    {
        RegistarViewModel rvm;
        public Registar()
        {
            InitializeComponent();
            BindingContext = rvm = new RegistarViewModel();

        }

        private void Button_Voltar_Clicked(object sender, EventArgs e)
        {
            Application.Current.MainPage = new Login();
        }
      
    }
}
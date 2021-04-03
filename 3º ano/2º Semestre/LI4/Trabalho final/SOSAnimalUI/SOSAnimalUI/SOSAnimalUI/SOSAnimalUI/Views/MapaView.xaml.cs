using SOSAnimalUI.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Maps;
using Xamarin.Forms.Xaml;

namespace SOSAnimalUI.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class MapaView : ContentPage
    {
        public MapaViewModel ViewModel { get; } = new MapaViewModel();
        public MapaView()
        {
            InitializeComponent();
            BindingContext = ViewModel;
            NavigationPage.SetHasNavigationBar(this, false);
        }

        private async void Clicked_BackPerfil(object sender, EventArgs e)
        {
          await  Navigation.PopAsync() ;
        }
        protected override void OnAppearing()
        {
            base.OnAppearing();

        }
        protected override void OnDisappearing()
        {
            base.OnDisappearing();
        }

       
    }
}
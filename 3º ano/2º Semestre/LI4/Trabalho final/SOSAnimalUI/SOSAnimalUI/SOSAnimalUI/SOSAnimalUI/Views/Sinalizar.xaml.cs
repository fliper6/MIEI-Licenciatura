using Plugin.Media;
using SOSAnimalUI.Helpers;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace SOSAnimalUI.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class Sinalizar : ContentPage , INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged1;

        private bool isGuest;

        ObservableCollection<String> items = new ObservableCollection<String>();
        public ObservableCollection<String> Items
        {
            get
            {
                return items;
            }
            set
            {
                items = value;
                NotifyPropertyChanged("Items");
            }
        }
        public Sinalizar(bool isguest)
        {
            InitializeComponent();
            isGuest = isguest;
            BindingContext = new SinalizacaoViewModel(isguest);
            NavigationPage.SetHasNavigationBar(this, false);
        }
      
       
        private void Clicked_BackPerfil(object sender, EventArgs e)
        {
            if (!isGuest) { 
                Application.Current.MainPage = new MainPage();
            }
            else{
                Application.Current.MainPage = new Login();
            }

        }

        private async void Clicked_Mapa (object sender, EventArgs e)
        {
            
            await Navigation.PushAsync(new MapaView());

        }

        private void NotifyPropertyChanged(String PropertyName)
        {
            PropertyChanged1?.Invoke(this, new PropertyChangedEventArgs(PropertyName));
        }
    }
}
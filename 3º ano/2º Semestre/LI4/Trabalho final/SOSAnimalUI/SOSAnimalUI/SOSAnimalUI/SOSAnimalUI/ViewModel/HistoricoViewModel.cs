using Newtonsoft.Json;
using SOSAnimalUI.Helpers;
using SOSAnimalUI.Model;
using SOSAnimalUI.Services;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace SOSAnimalUI.ViewModel
{
    class HistoricoViewModel : INotifyPropertyChanged
    {
        ApiServices apiServices = new ApiServices();

        public event PropertyChangedEventHandler PropertyChanged;

        ObservableCollection<Sinalizacao> items;
        public ObservableCollection<Sinalizacao> Items {
            get {
                return items;
            }
            set {
                items = value;
                NotifyPropertyChanged("Items");
            }
        }

        public HistoricoViewModel()
        {
             GetSins();
        }

        private void NotifyPropertyChanged(String PropertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(PropertyName));
        }
        public async void GetSins()
        { 
            Items = items = await apiServices.GetHistoricoSins(GlobalVars.UserAtual.Id);
            Items= new ObservableCollection<Sinalizacao>(Items.OrderByDescending(p => p.Data));

        }
    }
}

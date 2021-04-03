using SOSAnimalUI.Helpers;
using SOSAnimalUI.Model;
using SOSAnimalUI.Services;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace SOSAnimalUI.ViewModel
{
    class VisitasViewModel : INotifyPropertyChanged
    {
        ApiServices apiServices = new ApiServices();

        public event PropertyChangedEventHandler PropertyChanged;

        ObservableCollection<Visita> items;
        public ObservableCollection<Visita> Items
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

        public VisitasViewModel()
        {
            GetVisitas();
        }

        private void NotifyPropertyChanged(String PropertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(PropertyName));
        }
        public async void GetVisitas()
        {
            int idu = GlobalVars.UserAtual.Id;
            Items = await apiServices.GetVisitas(idu);
            Items = new ObservableCollection<Visita>(Items.OrderByDescending(p=>p.DataVisita));
           

        }
    }
}

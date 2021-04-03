using SOSAnimalUI.Helpers;
using SOSAnimalUI.Model;
using SOSAnimalUI.Services;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Text;

namespace SOSAnimalUI.ViewModel
{
    class AnimaisViewModel : INotifyPropertyChanged
    {
        ApiServices apiServices = new ApiServices();

        public event PropertyChangedEventHandler PropertyChanged;

        ObservableCollection<Animal> items;
        public ObservableCollection<Animal> Items
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

        public AnimaisViewModel()
        {
            GetAnimais();
        }

        private void NotifyPropertyChanged(String PropertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(PropertyName));
        }
        public async void GetAnimais()
        { 

            Items = items = await apiServices.GetAnimais();
        }
    }
}

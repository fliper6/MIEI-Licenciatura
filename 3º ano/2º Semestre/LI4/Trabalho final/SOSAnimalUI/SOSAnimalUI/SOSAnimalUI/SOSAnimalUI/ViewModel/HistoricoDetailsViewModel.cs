using SOSAnimalUI.Model;
using SOSAnimalUI.Services;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Text;
using Xamarin.Forms;

namespace SOSAnimalUI.ViewModel
{
    class HistoricoDetailsViewModel : INotifyPropertyChanged
    {

        ApiServices apiServices = new ApiServices();

        public event PropertyChangedEventHandler PropertyChanged;

        ObservableCollection<ImageSource> items = new ObservableCollection<ImageSource>();
        public ObservableCollection<ImageSource> Items
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
        
        public HistoricoDetailsViewModel(int idsin)
        {
            getImgsAsync(idsin);
        }
        private async void getImgsAsync(int idsin)
        {
            ObservableCollection<Imagem> imgList = await apiServices.GetImagens(idsin);

            if (imgList.Count() == 0) { return; }
            foreach (Imagem i in imgList){
                Image image = new Image();
                Stream stream = new MemoryStream(i.img);
                image.Source = ImageSource.FromStream(() => { return stream; });
                items.Add(image.Source);
            }
           
        }
        private void NotifyPropertyChanged(String PropertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(PropertyName));
        }
    }
}

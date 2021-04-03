using SOSAnimalUI.Helpers;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Text;

namespace SOSAnimalUI.ViewModel
{
    class PerfilViewModel : INotifyPropertyChanged
    {

        public event PropertyChangedEventHandler PropertyChanged;

        string emut = GlobalVars.UserAtual.Email;
        public string Emut
        {
            get {
                return emut;
            }
            set
            {
                emut = value;
                NotifyPropertyChanged("Emut");
            }
        }

        string nomeut = GlobalVars.UserAtual.Nome;
        public string Nomeut
        {
            get
            {
                return nomeut;
            }
            set
            {
                nomeut = value;
                NotifyPropertyChanged("Nomeut");
            }
        }

        string pwut = GlobalVars.UserAtual.Password;
        public string Pwut
        {
            get
            {
                return pwut;
            }
            set
            {
                pwut = value;
                NotifyPropertyChanged("Pwut");
            }
        }
        private void NotifyPropertyChanged(String PropertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(PropertyName));
        }
    }
}

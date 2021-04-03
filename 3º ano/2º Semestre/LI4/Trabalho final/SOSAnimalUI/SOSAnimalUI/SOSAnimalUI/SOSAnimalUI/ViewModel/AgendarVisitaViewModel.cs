
using SOSAnimalUI.Helpers;
using SOSAnimalUI.Model;
using SOSAnimalUI.Services;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using Xamarin.Forms;

namespace SOSAnimalUI.ViewModel
{
    class AgendarVisitaViewModel : INotifyPropertyChanged
    {

        ApiServices apiServices = new ApiServices();
        public bool IsClicked { get; set; }

        private DateTime _startDate = DateTime.Now;
        public DateTime StartDate
        {
            get { return _startDate; }
            set { _startDate = value; NotifyPropertyChanged("StartDate"); }
        }

        private TimeSpan _horaMarcada = DateTime.Now.TimeOfDay;
        
        public TimeSpan HoraMarcada
        {
            get { return _horaMarcada; }
            set { _horaMarcada = value; NotifyPropertyChanged("HoraMarcada"); }
        }

        string moti;
        public string Moti
        {
            get
            {
                return moti;
            }
            set
            {
                moti = value;
                NotifyPropertyChanged("Moti");
            }
        }  

        public event PropertyChangedEventHandler PropertyChanged;
        public void NotifyPropertyChanged(string name)
        {
            PropertyChangedEventHandler handler = PropertyChanged;
            if (handler != null)
                handler(this, new PropertyChangedEventArgs(name));
        }
        public ICommand GuardarCommand
        {
            get
            {
                return new Command(async () =>
                {
                    while (IsClicked)
                    {
                        await Task.Delay(25);
                    }

                    IsClicked = true;
                    
                    

                    if ((StartDate.Day.Equals(DateTime.Now.Day) && HoraMarcada < DateTime.Now.TimeOfDay) || HoraMarcada < DateTime.Today.AddHours(9).TimeOfDay || HoraMarcada > DateTime.Today.AddHours(18).TimeOfDay)
                    {
                        await Application.Current.MainPage.DisplayAlert("Erro!", "Hora inválida!", "OK");
                        IsClicked = false;
                        return;
                    }
                    /*else
                    {
                        
                       
                        await Application.Current.MainPage.DisplayAlert("Atualização completa!", dat.ToString(), "OK");

                        Application.Current.MainPage = new MainPage(); 
                        IsClicked = false;
                        return;
                    }*/
                    
                    DateTime dat = StartDate;
                    dat += HoraMarcada;

                    var isGuardadoVis = await GuardarVis(dat);

                    if (isGuardadoVis)
                    {
                        await Application.Current.MainPage.DisplayAlert("Agendamento efetuado!", "Espere pela confirmação da visita!", "OK");
                        Application.Current.MainPage = new MainPage();
                        IsClicked = false;
                        return;
                    }
                    else
                    {
                        await Application.Current.MainPage.DisplayAlert("Agendamento falhado!", "Erro no agendamento!", "OK");
                        IsClicked = false;
                        return;
                    }
                });
            }
        }
        public async Task<bool> GuardarVis(DateTime dat)
        {
            int idut = GlobalVars.UserAtual.Id;

            Visita vis = new Visita()
            {
                IdUser = idut,
                DataVisita = dat,
                Motivo = Moti,
                Status = "W",
            };


            return await apiServices.PushVisita(vis);
        }
    }

}

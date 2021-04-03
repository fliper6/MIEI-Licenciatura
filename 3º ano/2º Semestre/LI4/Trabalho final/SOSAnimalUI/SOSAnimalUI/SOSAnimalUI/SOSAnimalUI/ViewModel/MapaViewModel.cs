using Plugin.Geolocator;
using Plugin.Geolocator.Abstractions;
using SOSAnimalUI.Helpers;
using SOSAnimalUI.Model;
using SOSAnimalUI.Views;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using Xamarin.Essentials;
using Xamarin.Forms;
using Xamarin.Forms.Maps;
using Map = Xamarin.Forms.Maps.Map;
using Position = Xamarin.Forms.Maps.Position;


namespace SOSAnimalUI.ViewModel
{
    public class MapaViewModel : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        public ICommand ExecuteSetPosition { get; }
        public ICommand ExecuteGuardarPos { get; }

        Map mapa;
        public Map Mapa 
        {
            get
            {
                return mapa;
            }

            set
            {
                mapa = value;
                NotifyPropertyChanged("Mapa");
            }
        }

        Position position;
        public Position Position
        {
            get
            {
                return position;
            }
            set
            {
                position = value;
                NotifyPropertyChanged("Position");
            }
        }
        string street;
        public string Street
        {
            get
            {
                return street;
            }
            set
            {
                street = value;
                NotifyPropertyChanged("Street");
            }
        }

        string city;
        public string City
        {
            get
            {
                return city;
            }
            set
            {
                city = value;
                NotifyPropertyChanged("City");
            }
        }

        string country;
        public string Country
        {
            get
            {
                return country;
            }
            set
            {
                country = value;
                NotifyPropertyChanged("Country");
            }
        }

        public MapaViewModel()
        {
           
            ExecuteSetPosition = new Command(() => { SetPosition(Street, City, Country); });
         
            ExecuteGuardarPos = new Command(() => { GuardarPos(); });

            mapa = new Map()
            {
                IsShowingUser = true
            };
            LoadMap();

            Mapa.MapClicked += HandleMapClicked;
        }

        private void HandleMapClicked(object sender, MapClickedEventArgs e)
        {
           SetAddress(e.Position);
        }


        public async void LoadMap()
        {
            try
            {
                var locator = CrossGeolocator.Current;
                locator.DesiredAccuracy = 20;

                if (CrossGeolocator.IsSupported &&
                     CrossGeolocator.Current.IsGeolocationAvailable &&
                     CrossGeolocator.Current.IsGeolocationEnabled)
                {
                    CrossGeolocator.Current.PositionChanged += HandlePositionChanged;
                }

                if (locator.IsListening != true)
                {
                    await CrossGeolocator.Current.StartListeningAsync(TimeSpan.FromSeconds(1), 10);
                }

                var position = await locator.GetPositionAsync(TimeSpan.FromSeconds(10000));
                Position pos = new Position(position.Latitude, position.Longitude);

                SetAddress(pos);
            }
            catch (Exception ex)
            {
                await Application.Current.MainPage.DisplayAlert("Erro com a geolocalização(Code #loadmap)", ex.Message, "OK");

            }

           
        }
        private void HandlePositionChanged(object sender, PositionEventArgs e)
        {
            Plugin.Geolocator.Abstractions.Position position1 = e.Position;
            Position pos = new Position(position1.Latitude, position1.Longitude);
            SetAddress(pos);
        }
         
        public async void SetAddress(Position p)
        {
            try
            {

              
                var addrs = (await Geocoding.GetPlacemarksAsync(new Location(p.Latitude, p.Longitude))).FirstOrDefault();

                Street = $"{addrs.Thoroughfare} {addrs.SubThoroughfare}";
                City = $"{addrs.PostalCode} {addrs.Locality}";
                Country = addrs.CountryName;
                Position = p;

                Pin pin = new Pin
                {
                    Label = "The Place",
                    Address = $"{Street}, {City}, {Country}",
                    Type = PinType.Place,
                    Position = p
                };

                var latDegrees = Mapa.VisibleRegion?.LatitudeDegrees ?? 0.01;
                var longDegrees = Mapa.VisibleRegion?.LongitudeDegrees ?? 0.01;
                Mapa.MoveToRegion(new MapSpan(p, latDegrees, longDegrees));
                Mapa?.Pins?.Clear();
                Mapa?.Pins?.Add(pin);
            }
            catch (Exception ex)
            {
                await Application.Current.MainPage.DisplayAlert("Erro com a geolocalização(Code #setadress)", ex.Message, "OK");

            }

        
           
        }

        private async void SetPosition(string street, string city, string country)
        {

            try
            {
                var location = (await Geocoding.GetLocationsAsync($"{street}, {city}, {country}")).FirstOrDefault();

                if (location == null) return;
                var latDegrees = Mapa.VisibleRegion?.LatitudeDegrees ?? 0.01;
                var longDegrees = Mapa.VisibleRegion?.LongitudeDegrees ?? 0.01;
                Position = new Position(location.Latitude, location.Longitude);
                Mapa.MoveToRegion(new MapSpan(Position, latDegrees, longDegrees));

                Pin pin = new Pin
                {
                    Label = "The Place",
                    Address = $"{Street}, {City}, {Country}",
                    Type = PinType.Place,
                    Position = Position
                };
                Mapa?.Pins?.Clear();
                Mapa?.Pins?.Add(pin);
            }
            catch (Exception ex)
            {
                await Application.Current.MainPage.DisplayAlert("Erro com a geolocalização(Code #setposition)", ex.Message, "OK");

            }
        }

        private async void GuardarPos()
        {
            GlobalVars.posAtual = new Position(Position.Latitude, Position.Longitude);
            await CrossGeolocator.Current.StopListeningAsync();
            await Application.Current.MainPage.DisplayAlert("Posição guardada!", "A sua posição foi registada com sucesso!", "OK");


        }

        private void NotifyPropertyChanged(String PropertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(PropertyName));
        }


       
    }
}

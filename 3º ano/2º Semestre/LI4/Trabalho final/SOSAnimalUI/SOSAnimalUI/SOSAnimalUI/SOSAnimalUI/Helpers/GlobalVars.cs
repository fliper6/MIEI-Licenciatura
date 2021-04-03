using Plugin.Geolocator;
using SOSAnimalUI.Model;
using System;
using System.Threading.Tasks;
using Xamarin.Forms.Maps;

namespace SOSAnimalUI.Helpers
{
    class GlobalVars
    {
        public static Utilizador UserAtual = new Utilizador();

        public static Empregado EmpregadoAtual = new Empregado();

        public static Position posAtual = new Position();

        public static bool isEmpregadoLogged;

        public static string apiurl = "https://animalsos.azurewebsites.net/api";


        public static Utilizador GetUt()
        {
            return new Utilizador
            {
                Id = UserAtual.Id,
                Nome = UserAtual.Nome,
                Email = UserAtual.Email,
                NrTelemovel = UserAtual.NrTelemovel,
                Password = UserAtual.Password
            };
        }

        public static Position GetPos()
        {
            return new Position(posAtual.Latitude, posAtual.Longitude);
        }
        /*
        private async Task<Position> GetPosAtual()
        {
            var locator = CrossGeolocator.Current;
            locator.DesiredAccuracy = 20;

            if (CrossGeolocator.IsSupported &&
                 CrossGeolocator.Current.IsGeolocationAvailable &&
                 CrossGeolocator.Current.IsGeolocationEnabled)
            {
                var position = await locator.GetPositionAsync(TimeSpan.FromSeconds(10000));
                Position pos = new Position(position.Latitude, position.Longitude);

                return pos;
            }
            return new Position();
        }*/
    }
}

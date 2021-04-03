using SOSAnimalUI.Views;
using System;
using System.Globalization;
using System.Threading;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace SOSAnimalUI
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();
            String culture = "pt-PT";
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
            MainPage = new Login();

        }

        protected override void OnStart()
        {
        }

        protected override void OnSleep()
        {
        }

        protected override void OnResume()
        {
        }
    }
}

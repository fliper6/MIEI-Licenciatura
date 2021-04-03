
using SOSAnimalUI.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace SOSAnimalUI.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class AgendarVisita : ContentPage
    {
        public AgendarVisita()
        {
            InitializeComponent();
            BindingContext = new AgendarVisitaViewModel();
            pickHora.Time = DateTime.Now.TimeOfDay;
            pickData.MinimumDate = DateTime.Today;
            pickData.MaximumDate = DateTime.Today.AddMonths(1);

           
        }
     
        private void DatePicker_DateSelected(object sender, DateChangedEventArgs e)
        {
            //MainLabel.Text = e.NewDate.ToLongDateString();
        }

        private void Clicked_Back(object sender, EventArgs e)
        {
            Application.Current.MainPage = new MainPage();
        }
    }
}
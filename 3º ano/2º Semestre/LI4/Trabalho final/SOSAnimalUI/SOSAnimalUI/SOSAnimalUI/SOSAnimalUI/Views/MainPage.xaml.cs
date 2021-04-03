using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using SOSAnimalUI.Helpers;
using SOSAnimalUI.Model;
using SOSAnimalUI.Views;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;


namespace SOSAnimalUI
{
    
    [DesignTimeVisible(false)]
    public partial class MainPage : ContentPage
    {
        public MainPage()
        {
            InitializeComponent();
          
        }

       private void Clicked_Logout(object sender, EventArgs e)
        {
            // Tirar o utilizador como estando logged in
            GlobalVars.UserAtual = new Utilizador();
            GlobalVars.EmpregadoAtual = new Empregado();
            GlobalVars.isEmpregadoLogged = false;
            Application.Current.MainPage = new Login();
        }

        private void Clicked_Sinalizar(object sender, EventArgs e)
        {
            Application.Current.MainPage = new NavigationPage(new Sinalizar(false));
        }

        private void Clicked_Animais(object sender, EventArgs e)
        {
            Application.Current.MainPage = new Animais();
        }

        private void Clicked_Agendar(object sender, EventArgs e)
        {
            Application.Current.MainPage = new AgendarVisita();
        }

        private void Clicked_Visitas(object sender, EventArgs e)
        {
           
            Application.Current.MainPage = new Visitas();
        } 

        private void Clicked_Estatisticas(object sender, EventArgs e)
        {   
           
            Application.Current.MainPage = new Historico(0);
        }

        private void Clicked_Perfil(object sender, EventArgs e)
        {
            Application.Current.MainPage = new Perfil();
        }

        private void Sair_Clicked(object sender, EventArgs e)
        {
            System.Diagnostics.Process.GetCurrentProcess().CloseMainWindow();
        }


    }
}

using Plugin.Geolocator;
using Plugin.Media;
using SOSAnimalUI.Helpers;
using SOSAnimalUI.Model;
using SOSAnimalUI.Services;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Input;
using Xamarin.Forms;
using Xamarin.Forms.Internals;
using Xamarin.Forms.Maps;

namespace SOSAnimalUI.Views
{
    class SinalizacaoViewModel : INotifyPropertyChanged
    {
        ApiServices apiServices = new ApiServices();

        public event PropertyChangedEventHandler PropertyChanged;

        //nr de fotos
        private int count = 0;

        //bool para quando clica em sinalizar
        private bool IsClicked { get; set; }

        //Descrição
        string desc;
        public string Desc
        {
            get
            {
                return desc;
            }
            set
            {
                desc = value;
                NotifyPropertyChanged("Desc");
            }
        }


        //Lista das imgs path's
        ObservableCollection<String> items = new ObservableCollection<String>();
        public ObservableCollection<String> Items
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

        //Lista dos byte array das imagens
        private List<byte[]> byteArr { get; set; }

        private bool isGuest = false;
        public SinalizacaoViewModel(bool isguest)
        {
            byteArr = new List<byte[]>();
            isGuest = isguest;
        }

        public ICommand PickPhoto
        {
            get
            {
                return new Command(async () =>
                {
                    if (!CrossMedia.Current.IsPickPhotoSupported)
                    {
                        await Application.Current.MainPage.DisplayAlert("Photos Not Supported", ":( Permission not granted to photos.", "OK");
                        return;
                    } else if (count == 3)
                    {
                        await Application.Current.MainPage.DisplayAlert("Limite de fotos", "Só pode selecionar 3 fotos no máximo.", "OK");
                        return;
                    }
                    var file = await Plugin.Media.CrossMedia.Current.PickPhotoAsync(new Plugin.Media.Abstractions.PickMediaOptions
                    {
                        PhotoSize = Plugin.Media.Abstractions.PhotoSize.Medium,
                        CompressionQuality = 30

                    });


                    if (file == null) return;
                    /* 
                    Image img = new Image();
                    img.Source = ImageSource.FromStream(() =>
                    {
                        var stream = file.GetStream();
                        file.Dispose();
                        return stream;
                    });*/
                    byte[] imageArray = System.IO.File.ReadAllBytes(file.Path);
                    byteArr.Add(imageArray);
                    Items.Add(file.Path);
                    count++;

                });
            }
        }


        public ICommand EndSinalizar
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

                    var pos = GlobalVars.GetPos();

                    if (string.IsNullOrWhiteSpace(Desc))
                    {
                        await Application.Current.MainPage.DisplayAlert("Erro!", "Insira uma descrição!", "OK");
                        IsClicked = false;
                        return;
                    }
                    else if (pos.Latitude == 0 && pos.Longitude == 0)
                    {
                        await Application.Current.MainPage.DisplayAlert("Erro!", "Necessita de atribuir uma localização!", "OK");
                        IsClicked = false;
                        return;
                    }

                    bool isGuardado = await GuardarSin(pos);

                    if (!isGuardado) {
                        await Application.Current.MainPage.DisplayAlert("Atualização falhada Sin!", "Erro na sinalização!", "OK");
                        
                        if (isGuest){Application.Current.MainPage = new Login();}
                        else { Application.Current.MainPage = new MainPage(); }
                        
                        IsClicked = false;
                        return;
                    }

                    var isGuardadoImgs = await GuardarImgs();

                    if (isGuardadoImgs)
                    {
                        await Application.Current.MainPage.DisplayAlert("Atualização completa!", "A sua sinalização foi registada com sucesso!", "OK");
                        
                        if (isGuest){Application.Current.MainPage = new Login();}
                        else { Application.Current.MainPage = new MainPage();}
                        
                        IsClicked = false;
                        return;
                    }
                    else
                    {
                        await Application.Current.MainPage.DisplayAlert("Atualização falhada imgs!", "Erro na sinalização!", "OK");
                       
                        if (isGuest) { Application.Current.MainPage = new Login(); }
                        else { Application.Current.MainPage = new MainPage(); }
                        
                        IsClicked = false;
                        return;
                    }
                });
            }
        }

        public async Task<bool> GuardarSin(Position pos)
        {
            var ut = GlobalVars.GetUt();
            int idg = ut.Id;
            if (isGuest) { idg = 2; }
            Sinalizacao sin = new Sinalizacao()
            {
                IdUser = idg,
                Data = System.DateTime.Now,
                Nota = Desc,
                Status = "0",
                Lat = pos.Latitude,
                Long = pos.Longitude

            };


            return await apiServices.PushSinalizacao(sin);
        }

        public async Task<bool> GuardarImgs()
        {
            int idg;

            if (isGuest) {
                idg = 2; 
            }
            else {
                idg = GlobalVars.GetUt().Id;
            }

            int id = await apiServices.GetSinalizacaoLastId(idg); 
            bool isOk = true;
            for (int i = 0; i < count; i++)
            {
                Imagem im = new Imagem
                {
                    IdSinalizacao = id,
                    img = byteArr[i]

                };
                isOk = await apiServices.PushImagem(im);
                if (!isOk) { return false; }
            }

            return isOk;
        }

        /*
        async void UploadPhoto(object sender, EventArgs e)
        {
            await CrossMedia.Current.Initialize();

            if (!CrossMedia.Current.IsPickPhotoSupported)
            {
                //Toast.MakeText(this, "Upload not supported on this device", ToastLength.Short).Show();
                return;
            }

            var file = await CrossMedia.Current.PickPhotoAsync(new Plugin.Media.Abstractions.PickMediaOptions
            {
                PhotoSize = Plugin.Media.Abstractions.PhotoSize.Full,
                CompressionQuality = 40

            });

            // Convert file to byre array, to bitmap and set it to our ImageView
            
            byte[] imageArray = System.IO.File.ReadAllBytes(file.Path);
            Bitmap bitmap = BitmapFactory.DecodeByteArray(imageArray, 0, imageArray.Length);
            imgs.Add(bitmap);
            CrlView.ItemsSource=imgs;
            await Application.Current.MainPage.DisplayAlert("Erro no login!", imgs.Count.ToString(), "OK");

        }*/




        private void NotifyPropertyChanged(String PropertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(PropertyName));
        }
    }
}

import Business.Gestor_Media.MediaCenterLN;
import Presentation.Controller.Controller;
import Presentation.View.MediaCenterGUI;

public class App {
    public static void main(String[] args) throws Exception {
        MediaCenterLN m = new MediaCenterLN();
        MediaCenterGUI v = new MediaCenterGUI();
        Controller c = new Controller(m,v);
        c.initController();
    }
}

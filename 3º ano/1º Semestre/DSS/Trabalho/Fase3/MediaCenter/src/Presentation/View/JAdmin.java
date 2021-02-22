package Presentation.View;

//Imports
import Presentation.Controller.BooleanChangeObserver;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class JAdmin extends JFrame{

    //Variáveis de Instância
    private BooleanChangeObserver observer;
    public static final Color VERY_LIGHT_BLUE = new Color(204,229,255);

    //Janela_Media_Center
    public JAdmin(MediaCenterGUI view) {
        super ("Media Center");

        JPanel panel = new JPanel();
        setContentPane(panel);
        register(view);

        //Layout
        GridBagLayout layout = new GridBagLayout();
        GridBagConstraints gbc = new GridBagConstraints();
        panel.setLayout(layout);
        panel.setBackground(VERY_LIGHT_BLUE);

        gbc.fill = GridBagConstraints.BOTH;
        gbc.anchor = GridBagConstraints.CENTER;

        gbc.insets.top = 5;
        gbc.insets.bottom = 5;
        gbc.insets.left = 5;
        gbc.insets.right = 5;

        //Side Menu
        JMenuBar menuBar = new JMenuBar();
        JMenu sidemenu = new JMenu("Exit");
        JMenuItem quit = new JMenuItem("Quit");
        JMenuItem logout = new JMenuItem("Logout");

        sidemenu.add(logout);
        logout.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                observer.notifyLogout();
                dispose();
                view.criarLogin();
            }
        });

        menuBar.add(sidemenu);
        sidemenu.add(quit);
        quit.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                dispose();
                System.exit(0);
            }
        });

        setJMenuBar(menuBar);
    }

    //Método_Registar_como_Observer
    public void register(BooleanChangeObserver obs) {observer = obs;}
}

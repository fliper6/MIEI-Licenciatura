package Presentation.View;

//Imports
import Presentation.Controller.BooleanChangeObserver;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class JMain extends JFrame{

    //Variáveis de Instância
    private BooleanChangeObserver observer;
    public static final Color VERY_LIGHT_BLUE = new Color(204,229,255);

    //Janela_Media_Center
    public JMain(MediaCenterGUI view) {
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

        //Botão "Reproduzir Media"
        JButton b1 = new JButton("Reproduzir Media");
        gbc.ipadx = 30;
        gbc.gridx = 0;
        gbc.gridy = 0;
        layout.setConstraints(b1,gbc);
        b1.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                view.criarSubMain1(true);
                dispose();
            }
        });
        panel.add(b1);

        //Botão "Upload Media"
        JButton b = new JButton("Upload Media");
        gbc.ipadx = 60;
        gbc.gridx = 0;
        gbc.gridy = 2;
        layout.setConstraints(b,gbc);
        //Adicina ação ao botão do upload
        b.addActionListener(new ActionListener() {
            //Método dessa ação
            public void actionPerformed(ActionEvent actionEvent) {
                view.criarSubMain2();
                dispose();
            }
        });
        panel.add(b);
    }
    
    //Método_Registar_como_Observer
    public void register(BooleanChangeObserver obs) {observer = obs;}
}

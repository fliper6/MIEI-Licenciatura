package Presentation.View;

//Imports
import Presentation.Controller.BooleanChangeObserver;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class JSubMain1 extends JFrame {

    //Variáveis de Instância
    public static final Color VERY_LIGHT_BLUE = new Color(204,229,255);
    private BooleanChangeObserver observer;

    //Janela_Main1
    public JSubMain1(MediaCenterGUI view, Boolean isUser) {
        super ("Reproduzir Media");

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

        JMenuItem back = null;
        if (isUser) back = new JMenuItem("Back");
        else back = new JMenuItem("Logout");

        menuBar.add(sidemenu);
        sidemenu.add(back);
        back.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                dispose();
                if (isUser) view.criarMenu();
                else view.criarLogin();
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

        //Botão "Músicas do Sistema"
        JButton b = new JButton("Músicas");
        gbc.ipadx = 60;
        gbc.gridx = 0;
        gbc.gridy = 0;
        layout.setConstraints(b,gbc);
        b.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                view.criarRepMus(isUser);
                dispose();
            }
        });
        panel.add(b);

        //Botão "Vídeos do Sistema"
        JButton b2 = new JButton("Vídeos");
        gbc.ipadx = 60;
        gbc.gridx = 2;
        gbc.gridy = 0;
        layout.setConstraints(b2,gbc);
        b2.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                view.criarRepGen("Vídeo","",isUser,1);
                dispose();
            }
        });
        panel.add(b2);

        if (isUser) {
            //Botão "Músicas pessoais"
            JButton b3 = new JButton("Músicas Pessoais");
            gbc.ipadx = 60;
            gbc.gridx = 0;
            gbc.gridy = 1;
            layout.setConstraints(b3,gbc);
            b3.addActionListener(new ActionListener() {
                public void actionPerformed(ActionEvent actionEvent) {
                    view.criarRepGen("Música Pessoal","",isUser,4);
                    dispose();
                }
            });
            panel.add(b3);

            //Botão "Vídeos Pessoais"
            JButton b4 = new JButton("Vídeos Pessoais");
            gbc.ipadx = 60;
            gbc.gridx = 2;
            gbc.gridy = 1;
            layout.setConstraints(b4,gbc);
            b4.addActionListener(new ActionListener() {
                public void actionPerformed(ActionEvent actionEvent) {
                    view.criarRepGen("Vídeo Pessoal","",isUser,4);
                    dispose();
                }
            });
            panel.add(b4);
        }
    }

    public void register(BooleanChangeObserver obs) {observer = obs;}
}
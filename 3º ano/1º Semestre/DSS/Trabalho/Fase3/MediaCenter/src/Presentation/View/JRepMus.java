package Presentation.View;

//Imports
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class JRepMus extends JFrame {

    //Variáveis de Instância
    public static final Color VERY_LIGHT_BLUE = new Color(204,229,255);

    //Janela_Reproduzir_Música  
    public JRepMus(MediaCenterGUI view, Boolean isUser) {
        super ("Reproduzir Media");

        JPanel panel = new JPanel();
        setContentPane(panel);

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
        JMenuItem exit = new JMenuItem("Back");

        menuBar.add(sidemenu);
        sidemenu.add(exit);
        exit.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                view.criarSubMain1(isUser);
                dispose();
            }
        });

        setJMenuBar(menuBar);

        // LINHA 1 

        //Botão "Pop"
        JButton b = new JButton("Pop");
        gbc.ipadx = 40;
        gbc.gridx = 1;
        gbc.gridy = 0;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(b,gbc);
        b.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                view.criarRepGen("Pop","",isUser,2);
                dispose();
            }
        });
        panel.add(b);

        //Botão "Jazz"
        JButton b2 = new JButton("Jazz");
        gbc.ipadx = 40;
        gbc.gridx = 3;
        gbc.gridy = 0;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(b2,gbc);
        b2.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                view.criarRepGen("Jazz","",isUser,2);
                dispose();
            }
        });
        panel.add(b2);

        //Botão "Techno"
        JButton b3 = new JButton("Techno");
        gbc.ipadx = 40;
        gbc.gridx = 5;
        gbc.gridy = 0;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(b3,gbc);
        b3.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                view.criarRepGen("Techno","",isUser,2);
                dispose();
            }
        });
        panel.add(b3);

        // LINHA 2

        //Botão "Metal"
        JButton b4 = new JButton("Metal");
        gbc.ipadx = 40;
        gbc.gridx = 1;
        gbc.gridy = 2;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(b4,gbc);
        b4.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                view.criarRepGen("Metal","",isUser,2);
                dispose();
            }
        });
        panel.add(b4);

        //Botão "Rock"
        JButton b5 = new JButton("Rock");
        gbc.ipadx = 40;
        gbc.gridx = 3;
        gbc.gridy = 2;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(b5,gbc);
        b5.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                view.criarRepGen("Rock","",isUser,2);
                dispose();
            }
        });
        panel.add(b5);

        //Botão "Rap"
        JButton b6 = new JButton("Rap");
        gbc.ipadx = 40;
        gbc.gridx = 5;
        gbc.gridy = 2;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(b6,gbc);
        b6.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                view.criarRepGen("Rap","",isUser,2);
                dispose();
            }
        });
        panel.add(b6);
        
        // LINHA 3

        //Botão "Soul"
        JButton b7 = new JButton("Soul");
        gbc.ipadx = 40;
        gbc.gridx = 1;
        gbc.gridy = 4;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(b7,gbc);
        b7.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                view.criarRepGen("Soul","",isUser,2);
                dispose();
            }
        });
        panel.add(b7);

        //Botão "Outros"
        JButton b8 = new JButton("Outros");
        gbc.ipadx = 40;
        gbc.gridx = 3;
        gbc.gridy = 4;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(b8,gbc);
        b8.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                view.criarRepGen("Outros","",isUser,2);
                dispose();
            }
        });
        panel.add(b8);

        //Botão "Playlists"
        JButton b9 = new JButton("Playlists");
        gbc.ipadx = 40;
        gbc.gridx = 5;
        gbc.gridy = 4;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(b9,gbc);
        b9.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                view.criarRepGen("Playlist","",isUser,2);
                dispose();
            }
        });
        panel.add(b9); 
    } 
}
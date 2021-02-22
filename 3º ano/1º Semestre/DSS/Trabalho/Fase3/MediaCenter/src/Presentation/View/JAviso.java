package Presentation.View;

//Imports
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class JAviso extends JFrame {

    //Variáveis de Instância
    public static final Color VERY_LIGHT_BLUE = new Color(204,229,255);

    //Janela_Aviso2
    /*
    qualAviso = 0 -> erro login
    qualAviso = 1 -> erro botão jsubmain1
    qualAviso = 2 -> erro botão jrepmus
    qualAviso = 3 -> erro botão Playlists jsubmain1
    qualAviso = 4 -> erro botão medias pessoais jsubmain1
     */
    public JAviso(MediaCenterGUI view, int qualAviso, Boolean isUser) {
        super ("Aviso");

        JPanel panel = new JPanel();
        setContentPane(panel);

        //Layout
        GridBagLayout layout = new GridBagLayout();
        GridBagConstraints gbc = new GridBagConstraints();
        panel.setLayout(layout);
        panel.setBackground(VERY_LIGHT_BLUE);

        //Label "Aviso"
        JLabel l;
        if (qualAviso == 0) l = new JLabel("Username ou password incorretos.");
        else if (qualAviso == 3) l = new JLabel("Não existem playlists.");
        else if (qualAviso == 4) l = new JLabel("O utilizador não possui esse tipo de media.");
        else l = new JLabel("Não existe media dessa categoria.");
        gbc.weightx = 30;
        gbc.weighty = 30;
        gbc.gridx = 0;
        gbc.gridy = 0;
        layout.setConstraints(l,gbc);
        panel.add(l);

        //Botão "OK"
        JButton b = new JButton("OK");
        gbc.ipadx = 60;
        gbc.gridx = 0;
        gbc.gridy = 2;
        layout.setConstraints(b,gbc);
        b.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                dispose();
                if (qualAviso == 0) view.criarLogin();
                else if (qualAviso == 1 || qualAviso == 4) view.criarSubMain1(isUser);
                else view.criarRepMus(isUser);
            }
        });
        panel.add(b);
    }
}

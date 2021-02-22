package Presentation.View;

import Presentation.Controller.BooleanChangeObserver;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class JNomePlaylist extends JFrame {

    public static final Color VERY_LIGHT_BLUE = new Color(204,229,255);
    private BooleanChangeObserver observer;

    public JNomePlaylist(JSubMain2 main) {
        super ("Nome da Playlist");

        register(main);
        JPanel panel = new JPanel();
        setContentPane(panel);

        //Layout
        GridBagLayout layout = new GridBagLayout();
        GridBagConstraints gbc = new GridBagConstraints();
        panel.setLayout(layout);
        panel.setBackground(VERY_LIGHT_BLUE);

        //Label "Nome_Playlist"
        JLabel l = new JLabel("Nome da Playlist: ");
        gbc.weightx = 30;
        gbc.weighty = 30;
        gbc.gridx = 0;
        gbc.gridy = 0;
        layout.setConstraints(l,gbc);
        panel.add(l);

        //TextField_Nome_Playlist
        JTextField nomePTextfield = new JTextField(15);
        gbc.weightx = 30;
        gbc.weighty = 30;
        gbc.gridx = 1;
        gbc.gridy = 0;
        layout.setConstraints(nomePTextfield,gbc);
        panel.add(nomePTextfield);

        //Botão "Confirmar"
        JButton b = new JButton("Confirmar");
        gbc.ipadx = 60;
        gbc.gridx = 0;
        gbc.gridy = 3;
        layout.setConstraints(b,gbc);
        //Adicina ação ao botão de confirmar o upload
        b.addActionListener(new ActionListener() {
            //Método dessa ação
            public void actionPerformed(ActionEvent actionEvent) {
                observer.notifyNomePlaylist(nomePTextfield.getText());
                dispose();
            }
        });
        panel.add(b);
    }

    public void register(BooleanChangeObserver obs) {observer = obs;}
}

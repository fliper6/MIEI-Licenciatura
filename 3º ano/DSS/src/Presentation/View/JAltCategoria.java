package Presentation.View;

import Presentation.Controller.BooleanChangeObserver;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class JAltCategoria extends JFrame {

    public static final Color VERY_LIGHT_BLUE = new Color(204,229,255);
    private BooleanChangeObserver observer;

    public JAltCategoria(MediaCenterGUI view, String musica, Boolean isUser) {
        super ("Alterar Categoria");

        register(view);
        JPanel panel = new JPanel();
        setContentPane(panel);

        //Layout
        GridBagLayout layout = new GridBagLayout();
        GridBagConstraints gbc = new GridBagConstraints();
        panel.setLayout(layout);
        panel.setBackground(VERY_LIGHT_BLUE);

        //Side Menu
        JMenuBar menuBar = new JMenuBar();
        JMenu sidemenu = new JMenu("Exit");
        JMenuItem back = new JMenuItem("Back");

        menuBar.add(sidemenu);
        sidemenu.add(back);
        back.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                dispose();
                view.criarRepMus(isUser);
            }
        });
        setJMenuBar(menuBar);

        //Label "Nome_Playlist"
        JLabel l = new JLabel("Nova Categoria: ");
        gbc.weightx = 30;
        gbc.weighty = 30;
        gbc.gridx = 0;
        gbc.gridy = 0;
        layout.setConstraints(l,gbc);
        panel.add(l);

        //ComboBox "Géneros"
        String generos[] = {"Pop","Rock","Soul","Techno","Metal","Jazz","Rap","Outros"};
        JComboBox cb = new JComboBox(generos);
        cb.setBounds(50,50,90,20);
        gbc.gridx = 1;
        gbc.gridy = 0;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(cb,gbc);
        panel.add(cb);

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
                String generoTextfield = cb.getItemAt(cb.getSelectedIndex()).toString();
                observer.notifyNovaCategoria(musica,generoTextfield);
                dispose();
                view.criarRepMus(true);
            }
        });
        panel.add(b);
    }

    public void register(BooleanChangeObserver obs) {observer = obs;}
}

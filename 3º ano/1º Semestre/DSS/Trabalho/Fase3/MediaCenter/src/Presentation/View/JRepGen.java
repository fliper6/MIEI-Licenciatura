package Presentation.View;

//Imports
import Presentation.Controller.BooleanChangeObserver;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.util.List;

public class JRepGen extends JFrame {

    //Variáveis de Instância
    public static final Color VERY_LIGHT_BLUE = new Color(204,229,255);
    private BooleanChangeObserver observer;

    //Janela_Reproduzir_Genero
    public JRepGen(String genero, MediaCenterGUI view, List<String> lista, Boolean isUser) {
        super ("Reproduzir " + genero);

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
        JMenuItem exit = new JMenuItem("Back");

        menuBar.add(sidemenu);
        sidemenu.add(exit);
        exit.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                dispose();
                if(genero.equals("Vídeo") || genero.equals("Música Pessoal") || genero.equals("Vídeo Pessoal"))
                    view.criarSubMain1(isUser);
                else 
                    view.criarRepMus(isUser);
            }
        });

        setJMenuBar(menuBar);

        //ComboBox "Músicas"
        System.out.println();
        String display[] = new String[lista.size()];
        for(int i = 0; i < lista.size(); i++)
            display[i] = lista.get(i);
        JComboBox cb = new JComboBox(display);    
        cb.setBounds(50,50,90,20);    
        gbc.ipadx = 60;
        gbc.gridx = 0;
        gbc.gridy = 0;
        layout.setConstraints(cb,gbc);
        panel.add(cb);

        //Botão "Alterar categoria"
        JButton b1;
        String[] str = genero.split(" ");
        StringBuilder str1 = new StringBuilder();
        str1.append(str[0]);
        String gen = str1.toString();

        Boolean alterar = isUser && !gen.equals("Vídeo") && !gen.equals("Playlist") && !genero.equals("Música Pessoal");
        if (alterar) {
            b1 = new JButton("Alterar categoria");
            gbc.ipadx = 60;
            gbc.gridx = 1;
            gbc.gridy = 0;
            layout.setConstraints(b1,gbc);
            b1.addActionListener(new ActionListener() {
                public void actionPerformed(ActionEvent actionEvent) {
                    dispose();
                    String musica = cb.getItemAt(cb.getSelectedIndex()).toString();
                    view.criarAltCat(musica,isUser);
                }
            });
            panel.add(b1);
        }

        //Botão "Reproduzir"
        JButton b2 = new JButton("Reproduzir");
        gbc.ipadx = 60;
        gbc.gridx = 1;
        if (alterar) gbc.gridy = 1;
        else gbc.gridy = 0;
        layout.setConstraints(b2,gbc);
        b2.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                String musOuplay = cb.getItemAt(cb.getSelectedIndex()).toString(); 
                if(genero.equals("Playlist")) {
                    view.criarRepGen("Playlist_Específica",musOuplay,isUser,2);
                    dispose();
                }
                else {
                    try {
                        observer.notifyPlay(musOuplay);
                    } catch (Exception e) {
                        try {
                            throw new IOException(e.getMessage());
                        } catch (IOException ex) {
                            ex.printStackTrace();
                        }
                    }
                }
            }
        });
        panel.add(b2);
    }

    public void register(BooleanChangeObserver obs) {observer = obs;}
}
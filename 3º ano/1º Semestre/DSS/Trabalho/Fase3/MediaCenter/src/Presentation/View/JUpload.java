package Presentation.View;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import Presentation.Controller.BooleanChangeObserver;

public class JUpload extends JFrame {

    public static final Color VERY_LIGHT_BLUE = new Color(204,229,255);
    private BooleanChangeObserver observer;

    //JanelaUpload
    public JUpload(JSubMain2 main, int i, String diretoria, Boolean typeFile) {
        super ("Upload");
        
        register(main);
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

        //Label "Nome_Media"
        JLabel l = new JLabel("Nome da Media: ");
        gbc.gridx = 0;
        gbc.gridy = 0;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(l,gbc);
        panel.add(l);

        //Label "Nome_Artista"
        JLabel l2 = new JLabel("Artista da Media: ");
        gbc.gridx = 0;
        gbc.gridy = 1;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(l2,gbc);
        panel.add(l2);

        //Label "Género"
        JLabel l3 = new JLabel("Género da Media: ");
        gbc.gridx = 0;
        gbc.gridy = 2;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(l3,gbc);
        panel.add(l3);

        //TextField_Nome_Media
        JTextField nomeMTextfield = new JTextField(15);
        gbc.gridx = 1;
        gbc.gridy = 0;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(nomeMTextfield,gbc);
        panel.add(nomeMTextfield);

        //TextField_Nome_Artista
        JTextField nomeATextfield = new JTextField(15);
        gbc.gridx = 1;
        gbc.gridy = 1;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(nomeATextfield,gbc);
        panel.add(nomeATextfield);

        //ComboBox "Géneros" / Label "Vídeo"
        String generos[] = {"Pop","Rock","Soul","Techno","Metal","Jazz","Rap","Outros"};
        JComboBox cb = new JComboBox(generos);
        cb.setBounds(50,50,90,20);
        gbc.gridx = 1;
        gbc.gridy = 2;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(cb,gbc);
        if (typeFile) panel.add(cb);
        else {
            JLabel l4 = new JLabel("Vídeo");
            gbc.gridx = 1;
            gbc.gridy = 2;
            gbc.gridheight = 1;
            gbc.gridwidth = 1;
            layout.setConstraints(l4,gbc);
            panel.add(l4);
        }

        //Botão "Confirmar"
        JButton b = new JButton("Confirmar");
        gbc.gridx = 0;
        gbc.gridy = 3;
        gbc.gridheight = 1;
        gbc.gridwidth = 1;
        layout.setConstraints(b,gbc);
        //Adicina ação ao botão de confirmar o upload
        b.addActionListener(new ActionListener() {
            //Método dessa ação
            public void actionPerformed(ActionEvent actionEvent) {
                String generoTextfield = cb.getItemAt(cb.getSelectedIndex()).toString();
                if (typeFile) main.addMedia(nomeMTextfield.getText(),generoTextfield,nomeATextfield.getText(),diretoria);
                else main.addMedia(nomeMTextfield.getText(),"Vídeo",nomeATextfield.getText(),diretoria);

                dispose();
                if (i == 0) //Sinaliza a main que estamos no último ficheiro
                    observer.notifyUltimo();
                else observer.notifyUpload(null,i-1,null,typeFile); //senão gera uma JUpload nova para o próximo ficheiro
            }
        });
        panel.add(b);
    }

    public void register(BooleanChangeObserver obs) {observer = obs;}
}

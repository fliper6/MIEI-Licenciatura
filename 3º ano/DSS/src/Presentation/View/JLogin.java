package Presentation.View;

//Imports
import Presentation.Controller.BooleanChangeObserver;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class JLogin extends JFrame {

    //Variáveis de Instância
    private BooleanChangeObserver observer;
    public static final Color VERY_LIGHT_BLUE = new Color(204,229,255);

    //Janela_Login
    public JLogin(MediaCenterGUI view) {
        super ("Login");

        JPanel panel = new JPanel();
        setContentPane(panel);
        register(view);

        //Layout
        GridBagLayout layout = new GridBagLayout();
        GridBagConstraints gbc = new GridBagConstraints();
        panel.setLayout(layout);
        panel.setBackground(VERY_LIGHT_BLUE);

        //Side Menu
        JMenuBar menuBar = new JMenuBar();
        JMenu sidemenu = new JMenu("Exit");
        JMenuItem exit = new JMenuItem("Quit");

        menuBar.add(sidemenu);
        sidemenu.add(exit);
        exit.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                dispose();
                System.exit(0);
            }
        });

        setJMenuBar(menuBar);

        //Label "Utilizador"
        JLabel l = new JLabel("Utilizador: ");
        gbc.weightx = 30;
        gbc.weighty = 30;
        gbc.gridx = 0;
        gbc.gridy = 0;
        layout.setConstraints(l,gbc);
        panel.add(l);

        //Label "Password"
        JLabel l2 = new JLabel("Password: ");
        gbc.weightx = 30;
        gbc.weighty = 30;
        gbc.gridx = 0;
        gbc.gridy = 1;
        layout.setConstraints(l2,gbc);
        panel.add(l2);

        //TextField "Utilizador"
        JTextField utilizadorTextfield = new JTextField(15);
        gbc.weightx = 30;      
        gbc.weighty = 30;
        gbc.gridx = 1;
        gbc.gridy = 0;
        layout.setConstraints(utilizadorTextfield,gbc);
        panel.add(utilizadorTextfield);

        //TextField "Password"
        JPasswordField passwordTextfield = new JPasswordField(15);
        passwordTextfield.setEchoChar('*');
        gbc.weightx = 30;
        gbc.weighty = 30;
        gbc.gridx = 1;
        gbc.gridy = 1;
        layout.setConstraints(passwordTextfield,gbc);
        panel.add(passwordTextfield);

        //Botão "Login"
        JButton b1 = new JButton("Login");
        gbc.ipadx = 60;
        gbc.gridx = 0;
        gbc.gridy = 2;
        layout.setConstraints(b1,gbc);
        b1.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                observer.notifyLogin(utilizadorTextfield.getText(),passwordTextfield.getText());
                dispose();
            }
        });
        panel.add(b1);

        //Botão "Login"
        JButton b2 = new JButton("Convidado");
        gbc.ipadx = 60;
        gbc.gridx = 1;
        gbc.gridy = 2;
        layout.setConstraints(b2,gbc);
        b2.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                dispose();
                view.criarSubMain1(false);
            }
        });
        panel.add(b2);
    }

    //Método_Registar_como_Observer
    public void register(BooleanChangeObserver obs) {observer = obs;}
}
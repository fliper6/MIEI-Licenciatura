package Presentation.View;

//Imports
import Business.Gestor_Media.Media;
import Presentation.Controller.BooleanChangeObserver;
import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.swing.filechooser.FileSystemView;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class JSubMain2 extends JFrame implements BooleanChangeObserver {

    //Variáveis de Instância
    public static final Color VERY_LIGHT_BLUE = new Color(204,229,255);
    private MediaCenterGUI view;
    private BooleanChangeObserver observer;
    private List<Media> medias;
    private File[] files = null;

    //Janela_Main1
    public JSubMain2(MediaCenterGUI view) {
        super ("Upload Media");

        JPanel panel = new JPanel();
        setContentPane(panel);
        this.view = view;
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
        JMenuItem back = new JMenuItem("Back");
        JMenuItem quit = new JMenuItem("Quit");

        menuBar.add(sidemenu);
        sidemenu.add(back);
        back.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                dispose();
                JMain frame = new JMain(view);
                frame.setSize(450,200);
                frame.setVisible(true);
                frame.setResizable(false);
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

        //Botão "Músicas"
        JButton b = new JButton("Músicas");
        gbc.ipadx = 60;
        gbc.gridx = 0;
        gbc.gridy = 0;
        layout.setConstraints(b,gbc);
        b.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                FileNameExtensionFilter filter = new FileNameExtensionFilter("Ficheiros de Música"
                                                                            ,"wav","mp3","wma","pcm");
                getFiles(filter,true);
            }
        });
        panel.add(b);

        //Botão "Vídeos"
        JButton b2 = new JButton("Vídeos");
        gbc.ipadx = 60;
        gbc.gridx = 1;
        gbc.gridy = 0;
        layout.setConstraints(b2,gbc);
        b2.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                FileNameExtensionFilter filter = new FileNameExtensionFilter("Ficheiros de Vídeo"
                                                                            ,"wmv","mp4","mpk","avi");
                getFiles(filter,false);
            }
        });
        panel.add(b2);
    }

    public void getFiles(FileNameExtensionFilter filter, Boolean typeFile) {
        JFileChooser jfc = new JFileChooser(FileSystemView.getFileSystemView().getHomeDirectory());
        jfc.setFileFilter(filter);
        jfc.setMultiSelectionEnabled(true);
        jfc.setFileSelectionMode(JFileChooser.FILES_ONLY);

        int returnValue = jfc.showOpenDialog(null);
        if (returnValue == JFileChooser.APPROVE_OPTION) {
            files = jfc.getSelectedFiles();
            medias = new ArrayList<>();
            geraUpload(files[files.length-1],files.length-1,typeFile);
        }
    }

    public void geraUpload(File f, int i, Boolean typeFile) {
        String diretoria = f.getAbsolutePath();
        view.criarUpload(this,i,diretoria,typeFile);
    }

    public List<Media> getMedias() {
        List<Media> novaL = new ArrayList<>();
        for(int i = 0; i < this.medias.size(); i++) {
            novaL.add(this.medias.get(i));
        }
        return novaL;
    }

    public void addMedia(String nome, String genero, String artista, String diretoria) {
        medias.add(new Media(0,nome,genero,artista,diretoria));
    }

    public void notifyUltimo() {
        files = null;
        if (medias.size() > 1)
            view.criarNomePlaylist(this);
        else
            observer.notifyUpload(getMedias(),medias.size(),null,true);
    }

    public void notifyUpload(List<Media> m, int i, String nome, Boolean typeFile) {
        geraUpload(files[i],i,typeFile);
    }
    public void notifyNomePlaylist(String nome) {
        observer.notifyUpload(getMedias(),medias.size(),nome,true);
    }
    public void notifyNovaCategoria(String musica, String categoria) {}
    public void notifyLogin(String u, String p) {}
    public void notifyLogout() {}
    public List<String> notifyDisplayRep(String ctg, Boolean isUser) {return observer.notifyDisplayRep(ctg,isUser);}
    public List<String> notifyDisplayPlayEsp(String nP, Boolean isUser) {return observer.notifyDisplayRep(nP,isUser);}
    public List<String> notifyDisplayPlay() { return observer.notifyDisplayPlay();}
    public void notifyPlay(String musica) {}
    public void register(BooleanChangeObserver obs) {observer = obs;}
}
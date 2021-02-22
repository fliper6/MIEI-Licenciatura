package Cloud;

import java.util.*;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;
import Servidor.Worker;

public class SoundCloud {
    private ReentrantLock lock;

    private HashMap<String,String> utilizadores;
    private HashMap<String,Worker> usersLogged;
    private HashMap<Integer,Musica> musicas;
    private int lastAdded = 0; // so para saber o ultimo ID, mais rapido

    private int MAXDOWNLOADS = 5;
    private int num_downloads = 0;
    private Condition tooMany;

    // construtor simples, mete tudo vazio
    public SoundCloud(){
        this.utilizadores = new HashMap<>();
        this.musicas = new HashMap<>();
        this.lock = new ReentrantLock();
        this.tooMany = lock.newCondition();
        this.usersLogged = new HashMap<>();
    }

    // insere um utilizador que deu login
    public void insertLogged(String user, Worker wkr) {
        this.usersLogged.put(user,wkr);

    }

    // remove um utilizador que tenha dado logout
    public void removeLogged(String user) {
        this.usersLogged.remove(user);
    }

    // verifica se dado user já está logged in
    public boolean isLogged(String user) {
        boolean b;
        lock.lock();
        b = this.usersLogged.containsKey(user);
        lock.unlock();
        return b;
    }

    // indica se é possivel dar login (se não está autenticado esse user / se esse user existe)
    public boolean login(String user,String pw){
        boolean bool = false;
        lock.lock();
        if(this.utilizadores.containsKey(user)){
            if (this.utilizadores.get(user).equals(pw)) {
                bool = true;
            }
        }
        lock.unlock();
        return bool;
    }

    // regista um utilizador, com dada password
    public boolean register(String user, String pw) {
        lock.lock();
        if(this.utilizadores.containsKey(user)) {
            lock.unlock();
            return false;
        }
        this.utilizadores.put(user,pw);
        lock.unlock();
        return true;
    }

    // adiciona uma musica à coleçao
    public int addMusica(Musica m){
        int i;
        lock.lock();
        this.lastAdded++;
        m.setId(lastAdded);
        i = lastAdded;
        this.musicas.put(lastAdded,m);

        // Vai notificar todos os users que estão logged in
        Iterator it = this.usersLogged.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry pair = (Map.Entry)it.next();
            Worker w = (Worker)pair.getValue();
            w.notifica("*** A música "+m.getNome()+" do artista "+m.getArtista()+" foi uploaded! ***");
        }

        lock.unlock();
        return i;
    }

    // Retorna a música em forma de string (ver Musica), dado o seu ID
    public String getMusicaString(int id){
        String s = null;
        lock.lock();
        if(this.musicas.containsKey(id)) {
            s = this.musicas.get(id).toString();
        }
        lock.unlock();
        return s;
    }

    // permite que a musica seja downloaded (o upload terminou)
    public void allowMusica(int id){
        lock.lock();
        this.musicas.get(id).allowDownload();
        lock.unlock();
    }

    // bloqueia enquanto nao esta disponivel para download (ver funçao anterior) e se
    // o nº de downloads for superior ao limite imposto pelo programa (MAXDOWNLOADS)
    public boolean downloadMusica(int id) throws Exception{
        boolean b = false;
        lock.lock();
        if(this.musicas.containsKey(id)){
            this.musicas.get(id).available();
            num_downloads++;
            while(num_downloads > MAXDOWNLOADS) {
                tooMany.await();
            }
            b = true;
            this.musicas.get(id).downloaded();
        }
        lock.unlock();
        return b;
    }

    // acabou o envio do ficheiro, podemos sinalizar que acabou agora um download (ver funçao anterior)
    public void finished(){
        lock.lock();
        num_downloads--;
        tooMany.signalAll();
        lock.unlock();
    }

    // funçao auxiliar que retorna o hashmap inteiro
    public HashMap<Integer,Musica> getAllMusicas(){
        lock.lock();
        HashMap<Integer,Musica> musicas = this.musicas;
        lock.unlock();
        return musicas;
    }

    // filtra todos os ficheiros que têm pelo menos uma das tags no argumento
    public Set<Musica> filterTag(ArrayList<String> tags){
        lock.lock();
        Set<Musica> ret = new TreeSet<>();
        for(String tag: tags){
            for(Musica m : musicas.values()){
                if(m.containsTag(tag)) {
                    ret.add(m);
                }
            }
        }
        lock.unlock();
        return ret;
    }
}

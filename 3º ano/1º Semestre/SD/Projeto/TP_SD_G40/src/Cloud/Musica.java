package Cloud;

import java.util.ArrayList;
import java.util.Collections;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class Musica implements Comparable<Musica> {
    private int id;
    private String nome;
    private String artista;
    private int ano;
    private ArrayList<String> tags;
    private int downloads;
    private boolean available = false;
    private ReentrantLock lock = new ReentrantLock();
    private Condition uploading = lock.newCondition();

    public Musica(String nome, String artista, int ano, ArrayList<String> tags){
        this.id = -1;
        this.nome = nome;
        this.artista = artista;
        this.tags = tags;
        this.downloads = 0;
        this.ano = ano;
    }

    public void setId(int id) {
        lock.lock();
        this.id = id;
        lock.unlock();
    }

    public int getAno(){
        int ano;
        lock.lock();
        ano = this.ano;
        lock.unlock();
        return ano;
    }

    public int getId(){
        int id;
        lock.lock();
        id = this.id;
        lock.unlock();
        return id;
    }

    public String getNome(){
        String nome;
        lock.lock();
        nome = this.nome;
        lock.unlock();
        return nome;
    }

    public String getArtista(){
        String artista;
        lock.lock();
        artista = this.artista;
        lock.unlock();
        return artista;
    }

    public ArrayList<String> getTags(){
        ArrayList<String> tags = new ArrayList<>();
        lock.lock();
        this.tags.addAll(tags);
        lock.unlock();
        return tags;
    }

    public int getDownloads(){
        int downloads;
        lock.lock();
        downloads = this.downloads;
        lock.unlock();
        return downloads;
    }

    public void downloaded(){
        lock.lock();
        this.downloads++;
        lock.unlock();
    }

    public String toString(){
        String ret;
        lock.lock();
        ret = this.id + " - "
                + this.nome + ", "
                + this.artista
                + " (" + this.ano + ") "
                +this.tags.toString();
        lock.unlock();
        return ret;
    }

    public int compareTo(Musica m) {
        int ret;
        lock.lock();
        ret = Integer.compare(this.id,m.getId());
        lock.unlock();
        return ret;
    }

    public boolean containsTag(String s){
        boolean b;
        lock.lock();
        b = this.tags.stream().anyMatch(tag -> tag.equals(s));
        lock.unlock();
        return b;
    }

    public void available() throws Exception{
        lock.lock();
        while(!this.available) {
            uploading.await();
        }
        lock.unlock();
    }

    public void allowDownload(){
        lock.lock();
        this.available = true;
        uploading.signalAll();
        lock.unlock();
    }

}

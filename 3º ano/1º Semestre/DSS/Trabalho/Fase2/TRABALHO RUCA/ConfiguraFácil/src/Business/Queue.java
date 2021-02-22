package Business;

import java.util.ArrayList;

public class Queue {
    
    private ArrayList<Integer> configuracoes;
    
    public Queue (ArrayList<Integer> configuracoes) {
        this.configuracoes=configuracoes;
    }
    
    public ArrayList<Integer> getConfiguracoes () {
        return this.configuracoes;
    }
    
    public void setConfiguracoes (ArrayList<Integer> configuracoes) {
        this.configuracoes=configuracoes;
    }
}

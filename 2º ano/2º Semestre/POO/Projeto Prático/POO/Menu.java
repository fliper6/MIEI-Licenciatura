import java.io.Serializable;
import java.util.Arrays;
import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

public class Menu implements Serializable {
    // variáveis de instância
    private List<String> opcoes;
    private int opc;

    /**
     * Constructor for objects of class Menu
     */
    public Menu(String[] opcoes) {
        this.opcoes = Arrays.asList(opcoes);
        this.opc = 0;
    }

    /**
     * Método para apresentar o menu e ler uma opção.
     *
     */
    public void executa(String titulo) {
        do {
            showMenu(titulo);
            this.opc = lerOpcao();
        } while (this.opc == -1);
    }

    /** Apresentar o menu */
    private void showMenu(String titulo) {
        System.out.println("\n *** Menu " + titulo + " *** ");
        for (int i=0; i<this.opcoes.size(); i++) {
            System.out.print(i+1);
            System.out.print(" - ");
            System.out.println(this.opcoes.get(i));
        }
        System.out.println("0 - Sair e Guardar");
    }

    /** Ler uma opção válida */
    private int lerOpcao() {
        int opc;
        Scanner is = new Scanner(System.in);

        System.out.print("Opção: ");
        try {
            opc = is.nextInt();
        }
        catch (InputMismatchException e) { // Não foi inscrito um int
            opc = -1;
        }
        if (opc<0 || opc>this.opcoes.size()) {
            System.out.println("Opção Inválida!!!");
            opc = -1;
        }
        return opc;
    }

    /**
     * Método para obter a última opção lida
     */
    public int getOpcao() {
        return this.opc;
    }
}

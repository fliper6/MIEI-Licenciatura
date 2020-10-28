import java.io.*;
import java.util.*;

/**
 * Classe que representa uma Venda
 */
public class Venda implements IVenda, Serializable {

   private String produto;  /* AB1234*/
   private double preco;    /* 0.0 - 999.99*/
   private int    unidades; /* 1 - 200*/
   private String tipo;     /* P ou N*/
   private String cliente;  /* A1234*/
   private int    mes;      /* 1 - 12*/
   private int    filial;   /* 1 - 3*/

    //Construtor vazio
   public Venda() {
       this.produto  = "";
       this.preco    = 0.0 ;
       this.unidades = 0;
       this.tipo     = "";
       this.cliente  = "";
       this.mes      = 0;
       this.filial   = 0;
   }
    
   //Construtor por parametros
   public Venda(String pro, double pre, int uni, String tip, String cli, int mes, int fil) {
       this.produto  = pro;
       this.preco    = pre;
       this.unidades = uni;
       this.tipo     = tip;
       this.cliente  = cli;
       this.mes      = mes;
       this.filial   = fil;
   }
    
   //Getters e Setters
   public String getCodProd() { 
       return this.produto;
   } 
   
   public double getPreco() { 
       return this.preco;
   }
   
   public int getUnidades() { 
       return this.unidades;
   }
   
   public String getTipo() {
       return this.tipo;
   }
   
   public String getCodCli() {
       return this.cliente;
   }
   
   public int getMes() {
       return this.mes;
   }
   
   public int getFilial() {
       return this.filial;
   }
   
   //Metodos de Classe
   public static IVenda linhaToVenda(String linha) {
        //Inicializar Venda
        String codProd, codCli, tipo;
        int mes = 0; int fil = 0; int uni = 0; double preco = 0.00;
        
        //public String[] split(String regex) --> regex − the delimiting regular expression
        String[] campos = linha.split(" "); 
        
        codProd = campos[0];
        tipo = campos[3];
        codCli = campos[4];
        try { 
            preco = Double.parseDouble(campos[1]);
        }
        catch(InputMismatchException e) {return null;}
        catch(NumberFormatException e) {return null;}
        
        try { 
            uni = Integer.parseInt(campos[2]);
        }
        catch(InputMismatchException e) {return null;}
        catch(NumberFormatException e) {return null;}
        
        try { 
            mes = Integer.parseInt(campos[5]);
        }
        catch(InputMismatchException e) {return null;}
        catch(NumberFormatException e) {return null;}
        
        try { 
            fil = Integer.parseInt(campos[6]);
        }
        catch(InputMismatchException e) {return null;}
        catch(NumberFormatException e) {return null;}
        
        return new Venda(codProd,preco,uni,tipo,codCli,mes,fil);
   }

   public static boolean validaVenda(IVenda v) { 
    if(v == null) return false;

    if (!(v.getPreco() >= 0.00 && v.getPreco() <= 999.99))     return false;
    if (!(v.getUnidades() >= 1 && v.getUnidades() <= 200))     return false;
    if (!(v.getTipo().equals("P") || v.getTipo().equals("N"))) return false;
    if (!(v.getMes() >= 1 && v.getMes() <= 12))                return false;
    if (!(v.getFilial() >= 1 && v.getFilial() <= 3))           return false;
    
    return true;
   }
}
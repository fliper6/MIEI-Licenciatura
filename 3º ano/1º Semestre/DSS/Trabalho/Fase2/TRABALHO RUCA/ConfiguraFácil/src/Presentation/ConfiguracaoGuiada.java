/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Presentation;

import Business.Cliente;
import Business.Componente;
import Business.Facade;
import Business.Pacote;
import java.util.ArrayList;
import java.util.HashMap;
import javax.swing.DefaultListModel;
import javax.swing.JList;
import javax.swing.JOptionPane;

/**
 *
 * @author pc
 */
public class ConfiguracaoGuiada extends javax.swing.JFrame {

    ArrayList<Componente> componentes;
    HashMap<Pacote,ArrayList<Componente>> pacotes;
    DefaultListModel dlm;
    JList jl;
    DefaultListModel dlm1;
    JList jl1;
    String fase="";
    int nif;
    int indice1;
    ArrayList<Componente> escolhidos;
    ArrayList<Componente> chassis;
    ArrayList<Componente> pinturas;
    ArrayList<Componente> jantes;
    ArrayList<Componente> pneus;
    ArrayList<Componente> motores;
    ArrayList<Componente> di;
    ArrayList<Componente> de;
    Cliente cliente;
    String passado;
    ArrayList<Cliente> clientes;
    
    
    public ConfiguracaoGuiada() {
        try{
        this.componentes=Facade.getComponentes();
        this.pacotes=Facade.getpacotes();
        }
        catch(Exception e){}
        this.dlm=new DefaultListModel();
        this.fase="chassi";
        this.jLabel1.setText("chassi");
        this.dlm1=new DefaultListModel();
        desenharScrollableChassi();
        initComponents();
    }
    
    public ConfiguracaoGuiada(Cliente cliente,String passado, ArrayList<Cliente> clientes) {
        initComponents();
        try{
        this.componentes=Facade.getComponentes();
        this.pacotes=Facade.getpacotes();
        }
        catch(Exception e){}
        this.dlm=new DefaultListModel();
        this.fase="chassi";
        this.jLabel1.setText("chassi");
        this.dlm1=new DefaultListModel();
        this.nif=cliente.getNIF();
        this.cliente=cliente;
        this.passado=passado;
        this.clientes=clientes;
        this.escolhidos=new ArrayList<>();
        this.chassis=new ArrayList<>();
        this.pinturas=new ArrayList<>();
        this.jantes=new ArrayList<>();
        this.pneus=new ArrayList<>();
        this.motores=new ArrayList<>();
        this.di=new ArrayList<>();
        this.de=new ArrayList<>();
        for(Componente c : this.componentes){
            switch(c.getCategoria()){
                case "chassi" : this.chassis.add(c); break;
                case "pintura" : this.pinturas.add(c); break;
                case "jantes" : this.jantes.add(c); break;
                case "pneus" : this.pneus.add(c); break;
                case "motor" : this.motores.add(c); break;
                case "detalhe interior" : this.di.add(c); break;
                case "detalhe exterior" : this.de.add(c); break;
                default : break;
            }
        }
        desenharScrollableChassi();
    }
    
    public void desenharScrollableChassi() {
        for(Componente c : this.chassis)
            this.dlm.addElement(c.toString2());
        this.jl=new JList(this.dlm);
        this.jScrollPane1.setViewportView(this.jl);
    }
    
    public void desenharScrollablePintura() {
        this.jButton3.setVisible(true);
        this.dlm.clear();
        for(Componente c : this.pinturas)
            this.dlm.addElement(c.toString2());
        this.jl=new JList(this.dlm);
        this.jScrollPane1.setViewportView(this.jl);
        this.jLabel1.setText("pintura");
        this.jButton2.setVisible(false);
    }
    
    public void desenharScrollableJantes() {
        this.jButton3.setVisible(true);
        this.dlm.clear();
        for(Componente c : this.jantes)
            this.dlm.addElement(c.toString2());
        this.jl=new JList(this.dlm);
        this.jScrollPane1.setViewportView(this.jl);
        this.jLabel1.setText("jantes");
    }
    
    public void desenharScrollablePneus() {
        this.jButton3.setVisible(true);
        this.dlm.clear();
        for(Componente c : this.pneus)
            this.dlm.addElement(c.toString2());
        this.jl=new JList(this.dlm);
        this.jScrollPane1.setViewportView(this.jl);
        this.jLabel1.setText("pneus");
    }
    
    public void desenharScrollableMotor() {
        this.jButton3.setVisible(true);
        this.dlm.clear();
        for(Componente c : this.motores)
            this.dlm.addElement(c.toString2());
        this.jl=new JList(this.dlm);
        this.jScrollPane1.setViewportView(this.jl);
        this.jLabel1.setText("motor");
    }
    
    public void desenharScrollableDi() {
        this.jButton3.setVisible(true);
        this.dlm.clear();
        for(Componente c : this.di)
            this.dlm.addElement(c.toString2());
        this.jl=new JList(this.dlm);
        this.jScrollPane1.setViewportView(this.jl);
        this.jLabel1.setText("detalhes interiores");
    }
    
    public void desenharScrollableDe() {
        this.dlm.clear();
        for(Componente c : this.de)
            this.dlm.addElement(c.toString2());
        this.jl=new JList(this.dlm);
        this.jScrollPane1.setViewportView(this.jl);
        this.jLabel1.setText("detalhes exteriores");
    }
    
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane1 = new javax.swing.JScrollPane();
        jScrollPane2 = new javax.swing.JScrollPane();
        jButton1 = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jButton2 = new javax.swing.JButton();
        jButton3 = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jButton1.setText("Seguinte");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        jLabel1.setText("chassi/pintura/jantes/pneus/motor/di/de");

        jLabel2.setText("Selecionados");

        jButton2.setText("Voltar");
        jButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton2ActionPerformed(evt);
            }
        });

        jButton3.setText("Adicionar");
        jButton3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton3ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(86, 86, 86)
                .addComponent(jLabel1)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jLabel2)
                .addGap(142, 142, 142))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(47, 47, 47)
                        .addComponent(jButton2))
                    .addGroup(layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 329, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 132, Short.MAX_VALUE)
                        .addComponent(jButton3)
                        .addGap(18, 18, 18)
                        .addComponent(jButton1)
                        .addGap(42, 42, 42))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(18, 18, 18)
                        .addComponent(jScrollPane2)
                        .addContainerGap())))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(38, 38, 38)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(jLabel2))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 297, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jButton1)
                            .addComponent(jButton2)
                            .addComponent(jButton3))
                        .addGap(31, 31, 31))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 297, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        switch(this.fase){
            case "chassi" :  this.fase="pintura"; desenharScrollablePintura(); break;
            case "pintura" :  this.fase="jantes"; desenharScrollableJantes(); break;
            case "jantes" :  this.fase="pneus"; desenharScrollablePneus(); break;
            case "pneus" :  this.fase="motor"; desenharScrollableMotor(); break;
            case "motor" :  this.fase="detalhe interior"; desenharScrollableDi(); break;
            case "detalhe interior" :  this.fase="detalhe exterior"; desenharScrollableDe(); break;
            default: 
                JOptionPane.showMessageDialog(null,"Fase guiada terminou");
                new ConfiguracaoPosGuiada(this.componentes,this.pacotes,this.dlm1,this.escolhidos,this.nif,this.cliente,this.passado,this.clientes).setVisible(true); 
                this.dispose(); 
                break;
        }
    }//GEN-LAST:event_jButton1ActionPerformed

    private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton2ActionPerformed
        new FichaCliente(this.cliente,this.passado,this.clientes).setVisible(true);
        this.dispose();
    }//GEN-LAST:event_jButton2ActionPerformed

    private void jButton3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton3ActionPerformed
        this.indice1=this.jl.getSelectedIndex();
        switch(this.fase){
            case "chassi" : if(!escolhidos.contains(chassis.get(indice1))) {escolhidos.add(chassis.get(indice1)); dlm1.addElement(chassis.get(indice1).toString2()); jButton3.setVisible(false);} break;
            case "pintura" : if(!escolhidos.contains(pinturas.get(indice1))) {escolhidos.add(pinturas.get(indice1)); dlm1.addElement(pinturas.get(indice1).toString2()); jButton3.setVisible(false);} break;
            case "jantes" : if(!escolhidos.contains(jantes.get(indice1))) {escolhidos.add(jantes.get(indice1)); dlm1.addElement(jantes.get(indice1).toString2()); jButton3.setVisible(false);} break;
            case "pneus" : if(!escolhidos.contains(pneus.get(indice1))) {escolhidos.add(pneus.get(indice1)); dlm1.addElement(pneus.get(indice1).toString2()); jButton3.setVisible(false);} break;
            case "motor" : if(!escolhidos.contains(motores.get(indice1))) {escolhidos.add(motores.get(indice1)); dlm1.addElement(motores.get(indice1).toString2()); jButton3.setVisible(false);} break;
            case "detalhe interior" : if(!escolhidos.contains(di.get(indice1))) {escolhidos.add(di.get(indice1)); dlm1.addElement(di.get(indice1).toString2());} break;
            default : if(!escolhidos.contains(de.get(indice1))) {escolhidos.add(de.get(indice1)); dlm1.addElement(de.get(indice1).toString2());} break;
        }
        this.jl1=new JList(this.dlm1);
        this.jScrollPane2.setViewportView(this.jl1);
        if(!(this.fase.equals("detalhe interior") || this.fase.equals("detalhe exterior")))
                this.jButton3.setVisible(false);
    }//GEN-LAST:event_jButton3ActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(ConfiguracaoGuiada.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(ConfiguracaoGuiada.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(ConfiguracaoGuiada.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(ConfiguracaoGuiada.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new ConfiguracaoGuiada().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    private javax.swing.JButton jButton3;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    // End of variables declaration//GEN-END:variables
}

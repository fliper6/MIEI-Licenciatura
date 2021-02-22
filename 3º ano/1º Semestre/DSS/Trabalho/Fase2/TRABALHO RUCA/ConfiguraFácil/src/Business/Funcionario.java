/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Business;


public class Funcionario {
    
private String username;
private String password;
private String tipo;

public Funcionario (String username, String password, String tipo) {
    this.username=username;
    this.password=password;
    this.tipo=tipo;
}

public String getUsername () {
    return this.username;
}
    
public String getPassword () {
    return this.password;
}

public String getTipo () {
    return this.tipo;
}

public void setUsername (String username) {
    this.username=username;
}

public void setPassword (String password) {
    this.password=password;
}

public void setTipo (String tipo) {
    this.tipo=tipo;
}

@Override
public String toString () {
    StringBuilder sb = new StringBuilder();
    sb.append("Username:").append(username+"  ");
    sb.append("Tipo:").append(tipo+"\n");
    return sb.toString();
}
}

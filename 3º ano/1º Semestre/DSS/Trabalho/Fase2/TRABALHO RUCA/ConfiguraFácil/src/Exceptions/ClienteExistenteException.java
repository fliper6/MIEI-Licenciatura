/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Exceptions;

/**
 *
 * @author pc
 */
public class ClienteExistenteException extends Exception {
    
    public ClienteExistenteException(String message){
        super(message);
    }
}

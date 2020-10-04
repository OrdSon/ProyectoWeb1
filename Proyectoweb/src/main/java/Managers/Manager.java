/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Managers;

import java.sql.Date;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.DataSource;

/**
 *
 * @author samuelson
 */
public class Manager {

    public boolean crearUsuario(LinkedList<String> datos, DataSource dataSource, String tipo) {
        Usuario usuario = new Usuario();
        LinkedList<String> datosUsuario = new LinkedList<>();
        datosUsuario.add(datos.get(0));
        datosUsuario.add(datos.get(1));
        datosUsuario.add(tipo);

        if (comprobarNull(datosUsuario)) {
            usuario.crear(datosUsuario, dataSource);
            return true;
        } else {
            return false;
        }
    }

    protected boolean comprobarNull(String string) {
        if (string == null || string.isBlank()) {
            return false;
        }
        return true;
    }

    protected boolean comprobarNull(LinkedList<String> datos) {
        for (int i = 0; i < datos.size(); i++) {
            if (datos.get(i) == null || datos.get(i).isBlank()) {
                System.out.println("Algun dato es null");
                return false;
            }
        }
        return true;
    }

    protected Date stringAFecha(String fecha) {
        try {
            Date date = Date.valueOf(fecha);//converting string into sql date  
            return date;
        } catch (Exception e) {
            System.out.println("excepcion en fecha... no se porque jajajaja");
            return null;
        }
    }

    protected Time stringATime(String time) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm");
            long tiempo = dateFormat.parse(time).getTime();
            Time conversion = new Time(tiempo);
            return conversion;
        } catch (ParseException ex) {
            Logger.getLogger(Manager.class.getName()).log(Level.SEVERE, null, ex);
        }return null;
    }
}

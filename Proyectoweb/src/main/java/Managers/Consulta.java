/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Managers;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import javax.sql.DataSource;
import javax.swing.JOptionPane;

/**
 *
 * @author samuelson
 */
public class Consulta extends Manager{

    public Consulta() {
    }
    
    public boolean crear(LinkedList<String> datos, DataSource dataSource){
        
        if (comprobarNull(datos)) {
            String query = "INSERT INTO Consulta (costo, Especialidad_Titulo)"
                    + " VALUES (?,?)";

            try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
                estado.setInt(1, Integer.parseInt(datos.get(0)));
                estado.setString(2, datos.get(1));
                estado.executeUpdate();
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
                return false;
            }
        } else {
            return false;
        }
        return true;
    
    }
}

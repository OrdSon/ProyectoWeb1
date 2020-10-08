/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Managers;

import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import javax.sql.DataSource;
import javax.swing.JOptionPane;

/**
 *
 * @author samuelson
 */
public class Orden extends Manager{

    public Orden() {
    }
    
    public void crear(DataSource dataSource, InputStream inputStream, String nombre){
        String query = "INSERT INTO Orden (codigo, extension, orden) values (?,?,?)";
        if (nombre == null || nombre.isBlank()) {
            return;
        }
        if (inputStream == null) {
            return;
        }
            try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
                estado.setString(1, nombre);
                estado.setString(2, "pdf");
                estado.setBinaryStream(3, inputStream);
                estado.executeUpdate();
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
            }
        
    }
}

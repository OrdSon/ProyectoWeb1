/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Managers;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.LinkedList;
import javax.sql.DataSource;
import javax.swing.JOptionPane;

/**
 *
 * @author samuelson
 */
public class Usuario {

    public Usuario() {
    }
    public void crear(LinkedList<String> datos, DataSource dataSource){
         String query = "insert into Usuario (codigo, contraseña, tipo) values (?,?,?)";
         
        try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            for (int i = 0; i < datos.size(); i++) {
                if (datos.get(i) == null || datos.get(i).isBlank()) {
                    estado.setNull((i + 1), Types.VARCHAR);
                } else {
                    estado.setString((i + 1), datos.get(i));
                }
            }
            estado.executeUpdate();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
        }
    }
}

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
public class Reporte extends Manager {

    public Reporte() {
    }

    public void crear(DataSource dataSource, LinkedList<String> datos) {
        String query = "INSERT INTO Reporte (codigo, descripcion, Cita_codigo_cita) VALUES (?,?,?)";
        try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            for (int i = 0; i < datos.size(); i++) {
                estado.setString((i+1), datos.get(i));
            }
            
            estado.executeUpdate();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
        }
    }
}

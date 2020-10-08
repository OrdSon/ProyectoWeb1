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
public class Resultado {

    public Resultado() {

    }

    public void crear(DataSource dataSource, LinkedList<String> datos) {
        String query = "INSERT INTO Resultado (codigo, Reporte_codigo, Examen_codigo,Laboratorista_Usuario_codigo,Orden_codigo) VALUES (?,?,?,?,?)";
        if (datos.getLast() == null || datos.getLast().isBlank()) {
            query = "INSERT INTO Resultado (codigo, Reporte_codigo, Examen_codigo,Laboratorista_Usuario_codigo) VALUES (?,?,?,?)";
            datos.removeLast();
        }
        try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            for (int i = 0; i < datos.size(); i++) {
                if (i == 0) {
                    estado.setInt(1, Integer.parseInt(datos.get(i)));
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

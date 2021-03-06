/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Managers;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.LinkedList;
import javax.sql.DataSource;
import javax.swing.JOptionPane;

/**
 *
 * @author samuelson
 */
public class Laboratorista extends Manager{

    public Laboratorista() {

    }

    public boolean crear(LinkedList<String> datos, DataSource dataSource) {

        if (crearUsuario(datos, dataSource, "Laboratorista") && comprobarNull(datos)) {
            String query = "INSERT INTO Laboratorista (Usuario_codigo, Usuario_contraseña, nombre, DPI, email, telefono, numero_registro, fecha_registro)"
                    + " VALUES (?,?,?,?,?,?,?,?)";

            try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

                for (int i = 0; i < datos.size(); i++) {
                    if (i == 7) {
                        estado.setDate(i + 1, stringAFecha(datos.get(i)));
                    } else {
                        estado.setString((i + 1), datos.get(i));
                    }
                }
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

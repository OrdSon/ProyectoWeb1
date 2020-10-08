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
import java.sql.Types;
import java.util.LinkedList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import javax.swing.JOptionPane;

/**
 *
 * @author samuelson
 */
public class Cita extends Manager {

    DataSource dataSource;

    public Cita() {

        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/Hospital");
        } catch (NamingException exe) {
        }
    }

    public boolean crearCompleta(LinkedList<String> datos, InputStream orden, String nombre) {

        String query = "";

        if (datos.get(7) == null || datos.get(7).isBlank()) {
            query = "INSERT INTO Cita (codigo_cita, fecha, hora, consulta_especialidad, estado"
                    + ", Paciente_Usuario_codigo, Medico_Usuario_codigo) VALUES (?,?,?,?,?,?,?)";
        } else if (nombre == null || nombre.isBlank()) {
            query = "INSERT INTO Cita (codigo_cita, fecha, hora, consulta_especialidad, estado"
                    + ", Paciente_Usuario_codigo, Medico_Usuario_codigo, Examen_codigo) VALUES (?,?,?,?,?,?,?,?)";
        } else if (comprobarNull(datos)) {
            query = "INSERT INTO Cita (codigo_cita, fecha, hora, consulta_especialidad, estado"
                    + ", Paciente_Usuario_codigo, Medico_Usuario_codigo, Examen_codigo, Orden_codigo) VALUES (?,?,?,?,?,?,?,?,?)";
            Orden orden1 = new Orden();
            orden1.crear(dataSource, orden, nombre);
        }

        try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            if (datos.get(7) == null || datos.get(7).isBlank()) {
                estado.setString(1, datos.get(0));
                estado.setDate(2, stringAFecha(datos.get(1)));
                estado.setTime(3, stringATime(datos.get(2)));
                estado.setString(4, datos.get(3));
                estado.setString(5, datos.get(4));
                estado.setString(6, datos.get(5));
                estado.setString(7, datos.get(6));
            } else if (nombre == null || nombre.isBlank()) {
                estado.setString(1, datos.get(0));
                estado.setDate(2, stringAFecha(datos.get(1)));
                estado.setTime(3, stringATime(datos.get(2)));
                estado.setString(4, datos.get(3));
                estado.setString(5, datos.get(4));
                estado.setString(6, datos.get(5));
                estado.setString(7, datos.get(6));
                estado.setString(8, datos.get(7));
            } else {
                estado.setString(1, datos.get(0));
                estado.setDate(2, stringAFecha(datos.get(1)));
                estado.setTime(3, stringATime(datos.get(2)));
                estado.setString(4, datos.get(3));
                estado.setString(5, datos.get(4));
                estado.setString(6, datos.get(5));
                estado.setString(7, datos.get(6));
                estado.setString(8, datos.get(7));
                estado.setString(9, datos.get(8));
            }

            estado.executeUpdate();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
            return false;
        }
        return true;

    }
}

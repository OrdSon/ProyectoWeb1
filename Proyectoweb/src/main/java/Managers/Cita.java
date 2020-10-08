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
public class Cita extends Manager{

    public Cita() {
    }
    
    public boolean crear(LinkedList<String> datos, DataSource dataSource){
        if (comprobarNull(datos)) {
            String query = "INSERT INTO Cita (codigo_cita, fecha, hora, consulta_especialidad, Examen_codigo, Orden_codigo, estado"
                    + ", Paciente_Usuario_codigo, Medico_Usuario_codigo) VALUES (?,?,?,?,?,?,?,?,?)";

            try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
                estado.setString(1, datos.get(0));
                estado.setDate(2, stringAFecha(datos.get(1)));
                estado.setTime(3, stringATime(datos.get(2)));
                for (int i = 3; i < 9; i++) {
                    estado.setString(i, datos.get(i+1));
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

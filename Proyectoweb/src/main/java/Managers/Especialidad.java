/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Managers;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import javax.swing.JOptionPane;

/**
 *
 * @author samuelson
 */
public class Especialidad extends Manager{
    public boolean crear(String titulo, DataSource dataSource){
        if (comprobarNull(titulo)) {
            String query = "INSERT INTO Especialidad (Titulo)"
                    + " VALUES (?)";

            try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
                estado.setString(1, titulo);
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
    public LinkedList<String> obtener(DataSource dataSource){
        String query = "SELECT * FROM Especialidad";
        LinkedList<String> especialidades = new LinkedList<>();
        try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query);
                ResultSet resultado = estado.executeQuery()) {
            
            
            while (resultado.next()) {
                    especialidades.add(resultado.getString(1));
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
        } 
        return especialidades;
    }
    public void imprimir(HttpServletResponse response, DataSource dataSource){
        LinkedList<String> especialidades = obtener(dataSource);
        for (int i = 0; i < especialidades.size(); i++) {
            try {
                String especialidad = especialidades.get(i);
                response.getWriter().println("<label><input type=\"checkbox\" name = \""+especialidad+"\"/>"+
                        especialidad+"</label>");
            } catch (IOException ex) {
                Logger.getLogger(Especialidad.class.getName()).log(Level.SEVERE, null, ex);
            }
            }
    }
}

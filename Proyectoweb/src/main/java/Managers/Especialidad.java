/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Managers;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
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
    public LinkedList <String> obtenerActivas(HttpServletRequest request, DataSource dataSource) {
        Especialidad especialidad = new Especialidad();

        LinkedList<String> especialidades = especialidad.obtener(dataSource);
        if (especialidades == null) {
            JOptionPane.showMessageDialog(null, "Especialidades null?");
            return null;
        }
        LinkedList<String> datos = new LinkedList<>();
        for (int i = 0; i < especialidades.size(); i++) {
            
            String resultado = request.getParameter(especialidades.get(i));
            if (resultado != null) {

                datos.add(especialidades.get(i));

            }
        }
        return datos;
    }
    
    public String armarQuery(HttpServletRequest request, DataSource dataSource){
        String query = "SELECT  medico_tiene_especialidad.Especialidad_Titulo ,Medico.Usuario_codigo, "
                + "Medico.nombre, Medico.hora_inicio, Medico.hora_salida, Medico.email, Medico.DPI,"
                + " Medico.numero_colegiado, Medico.fecha_debut FROM Medico INNER JOIN  "
                + "medico_tiene_especialidad ON medico_tiene_especialidad.Medico_Usuario_codigo = "
                + "Medico.Usuario_codigo WHERE medico_tiene_especialidad.Especialidad_Titulo = ";
        
        LinkedList<String> activas = obtenerActivas(request, dataSource);
        if (activas == null || activas.isEmpty()) {
            return null;
        }
        
        for (int i = 0; i < activas.size(); i++) {
            if (i == activas.size()-1) {
                query += " '"+activas.get(i)+"' ";
            }else{
                query += " '"+activas.get(i)+"' OR ";
            }
        }
        return query;
    }
    public void imprimir(HttpServletResponse response, DataSource dataSource){
        LinkedList<String> especialidades = obtener(dataSource);
        for (int i = 0; i < especialidades.size(); i++) {
            try {
                String especialidad = especialidades.get(i);
                response.getWriter().println("<label><input type=\"checkbox\" name = \"" + especialidad + "\"/>"
                        + especialidad + "</label>");
            } catch (IOException ex) {
                Logger.getLogger(Especialidad.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}

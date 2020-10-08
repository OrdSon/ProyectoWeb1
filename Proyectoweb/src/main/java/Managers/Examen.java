/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Managers;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import javax.sql.DataSource;
import javax.swing.JOptionPane;

/**
 *
 * @author samuelson
 */
public class Examen extends Manager{

    public Examen() {
    }
    
    public boolean crear(LinkedList<String> datos, DataSource dataSource){
        
            String query = "INSERT INTO Examen (codigo, formato, orden, nombre, descripcion)"
                    + "VALUES (?,?,?,?,?)";

            try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

                for (int i = 0; i < datos.size(); i++) {
                    
                        estado.setString((i + 1), datos.get(i));
                    
                }
                estado.executeUpdate();
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
                return false;
            }
        
        return true;
    }
    
    public LinkedList<String> obtenerOpciones(DataSource dataSource){
        String query = "SELECT nombre FROM Examen";
        LinkedList<String> opciones = new LinkedList<>();
        try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query, Statement.RETURN_GENERATED_KEYS); 
                ResultSet resultado = estado.executeQuery()) {
            while (resultado.next()) {          
                String opcion = resultado.getString(1);
                opciones.add("<option value=\""+opcion+"\">"+opcion+"</option>");
            }
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
                return null;
            }
        if (opciones.isEmpty()) {
            return null;
        }
        return opciones;
    }
    public LinkedList <String> imprimirTabla(DataSource dataSource){
        LinkedList <String> examenes = new LinkedList<>();
        String query = "SELECT codigo, nombre, descripcion, orden FROM Examen";
        try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query);
                ResultSet resultado = estado.executeQuery()) {
            ResultSetMetaData meta = resultado.getMetaData();
            int columnas = meta.getColumnCount();

            examenes.add("<table id=\"tablaExamenes\" border=\"1\">");
            examenes.add("<tr>"
                    + "     <th>Codigo</th>"
                    + "     <th>Nombre</th>"
                    + "     <th>Descripcion</th>"
                    + "     <th>orden</th>"
                    + "   </tr>");

            while (resultado.next()) {
                examenes.add("<tr>");
                for (int i = 0; i < columnas; i++) {
                    examenes.add("<td>" + resultado.getString(i + 1) + "</td>");
                }
                examenes.add("</tr>");
            }

            examenes.add("</table>");

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e.getMessage());

        }
        return examenes;
    }
    
}

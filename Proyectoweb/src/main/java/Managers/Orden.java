/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Managers;

import java.io.InputStream;
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
    public LinkedList<String> imprimirOrdenes(DataSource dataSource) {
        
        String query = "SELECT codigo FROM Orden;";
        LinkedList<String> imprimir = new LinkedList<>();
        try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query);
                ResultSet resultado = estado.executeQuery()) {
            ResultSetMetaData meta = resultado.getMetaData();
            int columnas = meta.getColumnCount();
            imprimir.add("<table id=\"tablaOrdenes\" border = \"1\">");
            imprimir.add("<tr>"
                    + "     <th>Codigo</th>"
                    + "   </tr>");

            while (resultado.next()) {
                imprimir.add("<tr>");
                for (int i = 0; i < columnas; i++) {
                    imprimir.add("<td>" + resultado.getString(i + 1) + "</td>");
                }
                imprimir.add("</tr>");
            }
            imprimir.add("</table>");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e.getMessage());

        }
        if (imprimir.isEmpty()) {
            return null;
        }
        return imprimir;
    }
}

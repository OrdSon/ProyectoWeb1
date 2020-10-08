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
public class Reporte extends Manager {

    public Reporte() {
    }

    public void crear(DataSource dataSource, LinkedList<String> datos) {
        String query = "INSERT INTO Reporte (codigo, descripcion, Cita_codigo_cita) VALUES (?,?,?)";
        try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            for (int i = 0; i < datos.size(); i++) {
                estado.setString((i + 1), datos.get(i));
            }

            estado.executeUpdate();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
        }
    }

    public LinkedList<String> imprimirReportes(DataSource dataSource) {
        String query = "SELECT * FROM Reporte;";
        LinkedList<String> imprimir = new LinkedList<>();
        try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query);
                ResultSet resultado = estado.executeQuery()) {
            ResultSetMetaData meta = resultado.getMetaData();
            int columnas = meta.getColumnCount();
            imprimir.add("<table id=\"tablaReportes\" border = \"1\">");
            imprimir.add("<tr>"
                    + "     <th>Codigo</th>"
                    + "     <th>Descripcion</th>"
                    + "     <th>Cita</th>"
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

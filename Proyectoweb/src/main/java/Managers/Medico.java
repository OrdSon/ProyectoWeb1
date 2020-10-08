/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Managers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import javax.swing.JOptionPane;
import servlets.servlet;

/**
 *
 * @author samuelson
 */
public class Medico extends Manager {

    public Medico() {
    }

    public boolean crear(LinkedList<String> datos, DataSource dataSource) {
        if (crearUsuario(datos, dataSource, "Medico") && comprobarNull(datos)) {
            String query = "INSERT INTO Medico (Usuario_codigo, Usuario_contraseña, nombre,hora_inicio, hora_salida, email, telefono, DPI , numero_colegiado, fecha_debut)"
                    + " VALUES (?,?,?,?,?,?,?,?,?,?)";

            try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

                for (int i = 0; i < datos.size(); i++) {
                    if (i == 3 || i == 4) {
                        estado.setTime((i + 1), stringATime(datos.get(i)));
                    } else if (i == 9) {
                        estado.setDate((i + 1), stringAFecha(datos.get(i)));
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

    public void buscarPorNombre(HttpServletRequest request, HttpServletResponse response, DataSource dataSource) {
        String nombre = request.getParameter("buscarNombre");
        String query = "SELECT Usuario_codigo, nombre, hora_inicio, hora_salida, email, DPI, numero_colegiado, fecha_debut FROM Medico WHERE nombre LIKE '%" + nombre + "%'";
        try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query);
                ResultSet resultado = estado.executeQuery()) {
            ResultSetMetaData meta = resultado.getMetaData();
            int columnas = meta.getColumnCount();
            PrintWriter writer = response.getWriter();

            writer.print("<table>");
            writer.print("<tr>"
                    + "     <th>Codigo</th>"
                    + "     <th>Nombre</th>"
                    + "     <th>Hora inicio</th>"
                    + "     <th>Hora salida</th>"
                    + "     <th>Hora E-mail</th>"
                    + "     <th>Hora DPI</th>"
                    + "     <th>Hora Numero colegiado</th>"
                    + "     <th>Hora Fecha debut</th>"
                    + "   </tr>");

            while (resultado.next()) {
                writer.println("<tr>");
                for (int i = 0; i < columnas; i++) {
                    writer.println("<td>" + resultado.getString(i + 1) + "</td>");
                }
                writer.println("</tr>");
            }

            writer.print("</table>");

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e.getMessage());

        } catch (IOException ex) {
            Logger.getLogger(servlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public LinkedList<String> imprimirMedicos(DataSource dataSource, String query) {
        if (query == null) {
            return null;
        }
        LinkedList<String> imprimir = new LinkedList<>();
        try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query);
                ResultSet resultado = estado.executeQuery()) {
            ResultSetMetaData meta = resultado.getMetaData();
            int columnas = meta.getColumnCount();
            imprimir.add("<table id=\"table\" border = \"1\">");
            imprimir.add("<tr>"
                    + "     <th>Especialidad</th>"
                    + "     <th>Codigo</th>"
                    + "     <th>Nombre</th>"
                    + "     <th>Hora inicio</th>"
                    + "     <th>Hora salida</th>"
                    + "     <th>Hora E-mail</th>"
                    + "     <th>Hora DPI</th>"
                    + "     <th>Hora Numero colegiado</th>"
                    + "     <th>Hora Fecha debut</th>"
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

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
public class Administrador extends Manager {

    public Administrador() {
    }

    public boolean crear(LinkedList<String> datos, DataSource dataSource) {

        if (crearUsuario(datos, dataSource, "Administrador") && comprobarNull(datos)) {
            String query = "INSERT INTO Administrador (Usuario_codigo, Usuario_contraseña, nombre, DPI)"
                    + " VALUES (?,?,?,?)";

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

    public LinkedList<String> datos(DataSource dataSource, String codigo) {
        String query = "SELECT nombre, Usuario_codigo FROM Administrador WHERE Administrador.Usuario_codigo = '" + codigo + "'";
        LinkedList<String> imprimir = new LinkedList<>();
        try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query);
                ResultSet resultado = estado.executeQuery()) {
            ResultSetMetaData meta = resultado.getMetaData();
            int columnas = meta.getColumnCount();
            imprimir.add("<label>Nombre</label>");
            imprimir.add("<label>Codigo</label>");
            while (resultado.next()) {
                imprimir.add("<div class=\"entradas\">");
                for (int i = 0; i < columnas; i++) {

                    imprimir.add("<label>" + resultado.getString(i + 1) + "</label>");
                }
                imprimir.add("</div>");
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e.getMessage());

        }
        if (imprimir.isEmpty()) {
            return null;
        }
        return imprimir;
    }

    public LinkedList<String> verReportes(int eleccion, DataSource dataSource) {
        String informes = "select Medico_usuario_codigo as medico, count(*)citas from Cita inner join Reporte on Cita.codigo_cita = Reporte.Cita_codigo_cita group by medico order by citas desc limit 10";
        String medicosMenos = "select Medico_usuario_codigo as medico, count(*)citas from Cita inner join Reporte on Cita.codigo_cita = Reporte.Cita_codigo_cita group by medico order by citas desc limit 10";
        String examenMas = "select Medico_usuario_codigo as medico, count(*)citas from Cita inner join Reporte on Cita.codigo_cita = Reporte.Cita_codigo_cita group by medico order by citas desc limit 10";
        String medicosMasExamenes = "select Medico_Usuario_codigo as codigo,  count(*)Examenes from Cita where Examen_codigo != null group by codigo order by Examenes desc";
        String query = "";

        if (eleccion == 1) {
            query = informes;
        } else if (eleccion == 2) {
            query = medicosMenos;
        } else if (eleccion == 3) {
            query = examenMas;
        } else if (eleccion == 4) {
            query = medicosMasExamenes;
        }
        LinkedList<String> imprimir = new LinkedList<>();
        try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query);
                ResultSet resultado = estado.executeQuery()) {
            ResultSetMetaData meta = resultado.getMetaData();
            int columnas = meta.getColumnCount();
            imprimir.add("<table id=\"table\" border = \"1\">");
            imprimir.add("<tr>");
            if (eleccion == 1 || eleccion == 2) {
                imprimir.add("<th>Medico</th>");
                imprimir.add("<th>Citas</th>");
            } else if (eleccion == 3) {
                imprimir.add("<th>Nombre</th>");
                imprimir.add("<th>Examenes</th>");
            } else if (eleccion == 4) {
                imprimir.add("<th>Medico</th>");
                imprimir.add("<th>Examenes</th>");
            }
            imprimir.add("</tr>");
            
            while (resultado.next()) {
                imprimir.add("<tr>");
                for (int i = 0; i < columnas; i++) {

                    imprimir.add("<td>" + resultado.getString(i + 1) + "</td>");
                }
                imprimir.add("</tr>");
            }imprimir.add("</table>");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e.getMessage());

        }
        if (imprimir.isEmpty()) {
            return null;
        }
        return imprimir;
    }

}

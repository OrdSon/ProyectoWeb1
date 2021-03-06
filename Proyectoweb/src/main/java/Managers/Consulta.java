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
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;
import javax.swing.JOptionPane;

/**
 *
 * @author samuelson
 */
public class Consulta extends Manager{

    public Consulta() {
    }
    
    public boolean crear(LinkedList<String> datos, DataSource dataSource){
        
        if (comprobarNull(datos)) {
            String query = "INSERT INTO Consulta (costo, Especialidad_Titulo)"
                    + " VALUES (?,?)";

            try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
                estado.setInt(1, Integer.parseInt(datos.get(0)));
                estado.setString(2, datos.get(1));
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
    
     public boolean validarEInsertar(HttpServletRequest request, DataSource dataSource,String precio) {
        Especialidad especialidad = new Especialidad();

        LinkedList<String> especialidades = especialidad.obtener(dataSource);
        if (especialidades == null) {
            JOptionPane.showMessageDialog(null, "Especialidades null?");
            return false;
        }
        
        for (int i = 0; i < especialidades.size(); i++) {
            LinkedList<String> datos = new LinkedList<>();
            String resultado = request.getParameter(especialidades.get(i));
            if (resultado != null) {
                datos.add(precio);
                datos.add(especialidades.get(i));
                crear(datos, dataSource);
            }
        }
        return true;
    }
}

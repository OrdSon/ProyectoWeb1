<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.LinkedList"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <%!DataSource dataSource;%>
        <%
            try {

                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                dataSource = (DataSource) envContext.lookup("jdbc/Hospital");
            } catch (NamingException exe) {
            }
        %>
        <title>Registrar Consulta</title>
        <link rel="stylesheet" href="../Estilos/estiloRegistrarMedico.css">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <div class="envoltura">
            <div class="titulo">
                <h1>Registrar Consulta</h1>
            </div>
            <div class="formulario">
                <form name="form" method="post" action="../Registros/consultaRegistrada.jsp">
                    <div class="entradas">
                        <label> Especialidades: </label>
                        <div class="selectBox" onclick="showCheckboxes()" required>
                            <select>
                                <option>Select an option</option>
                            </select>
                            <div class="overSelect"></div>
                        </div>
                        <div id="checkboxes">
                            <%String query = "SELECT * FROM Especialidad";
                                LinkedList<String> especialidades = new LinkedList<>();
                                try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query);
                                        ResultSet resultado = estado.executeQuery()) {

                                    while (resultado.next()) {
                                        String especialidad = resultado.getString(1);
                                        out.print("<label><input type=\"checkbox\" name = \"" + especialidad + "\"/>"
                                                + especialidad + "</label>");
                                    }
                                } catch (SQLException e) {
                                    JOptionPane.showMessageDialog(null, e.getMessage());
                                }

                            %>
                            
                        </div>
                    </div>
                    <div class="entradas">
                        <label> Precio: </label>
                        <input type="text" class="input" name="precio" required>
                    </div>
                    <div class="enviar">
                        <input type="submit" value="Registrar" class="boton">
                    </div>
                </form>
            </div>
        </div>
        <script>
            var expanded = false;

            function showCheckboxes() {
                var checkboxes = document.getElementById("checkboxes");
                if (!expanded) {
                    checkboxes.style.display = "block";
                    expanded = true;
                } else {
                    checkboxes.style.display = "none";
                    expanded = false;
                }
            }
        </script>
    </body>

</html>

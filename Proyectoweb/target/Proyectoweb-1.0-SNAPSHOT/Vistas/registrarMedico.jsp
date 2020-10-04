<%-- 
    Document   : registrarMedico
    Created on : 4/10/2020, 01:17:22
    Author     : samuelson
--%>

<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.LinkedList"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="Managers.Especialidad"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%!DataSource dataSource; %>
        <%!Especialidad especialidad = new Especialidad();%>
        <%
            try {

                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                dataSource = (DataSource) envContext.lookup("jdbc/Hospital");
            } catch (NamingException exe) {
            }
        %>
        <title>Registrar</title>
        <link rel="stylesheet" href="../Estilos/estiloRegistrarMedico.css">
    </head>
    <body>
        <div class="envoltura">
            <div class="titulo">
                <h1>Registrar medico</h1>
            </div>
            <form action="../Registros/medicoRegistrado.jsp" method = "post">
                <div class="formulario">
                    <div class="entradas">
                        <label> Codigo: </label>
                        <input type="text" class="input" name="codigo" required>
                    </div>
                    <div class="entradas">
                        <label> Contraseña: </label>
                        <input type="password" class="input" name="pass" required>
                    </div>
                    <div class="entradas">
                        <label> Nombre completo: </label>
                        <input type="text" class="input" name="nombre" required>
                    </div>
                    <div class="entradas">
                        <label>Hora de entrada:</label>
                        <input type="time" name="horaInicio" required>
                    </div>
                    <div class="entradas">
                        <label>Hora de salida:</label>
                        <input type="time" name="horaSalida" required>
                    </div>
                    <div class="entradas">
                        <label> Telefono: </label>
                        <input type="text" class="input" name="telefono" required>
                    </div>
                    <div class="entradas">
                        <label> E-mail: </label>
                        <input type="email" class="input" name="email" required>
                    </div>
                    <div class="entradas">
                        <label>Fecha debut:</label>
                        <input type="date" name="fecha" required>
                    </div>
                    <div class="entradas">
                        <label> DPI: </label>
                        <input type="text" class="input" name="dpi" required>
                    </div>

                    <div class="entradas">
                        <label> Numero de colegiado: </label>
                        <input type="text" class="input" name="colegiado" required>
                    </div>
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
                                        out.print("<label><input type=\"checkbox\" name = \""+especialidad+"\"/>"+
                        especialidad+"</label>");
                                    }
                                } catch (SQLException e) {
                                    JOptionPane.showMessageDialog(null, e.getMessage());
                                }                                
                                
                            %>
                        </div>
                    </div>
                    <div class="enviar">
                        <input type="submit" value="Registrar" class="boton" >
                    </div>
                </div>
            </form>
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
        <style>
            .multiselect {
                width: 200px;
            }

            .selectBox {
                position: relative;
            }

            .selectBox select {
                width: 100%;
                font-weight: bold;
            }

            .overSelect {
                position: absolute;
                left: 0;
                right: 0;
                top: 0;
                bottom: 0;
            }

            #checkboxes {
                display: none;
                border: 1px #dadada solid;
            }

            #checkboxes label {
                display: block;
            }

            #checkboxes label:hover {
                background-color: #1e90ff;
            }
        </style>

    </body>
</html>

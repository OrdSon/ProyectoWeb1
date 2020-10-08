<%-- 
    Document   : encontrarMedico
    Created on : 5/10/2020, 08:28:01
    Author     : samuelson
--%>

<%@page import="Managers.Examen"%>
<%@page import="Managers.Especialidad"%>
<%@page import="java.util.LinkedList"%>
<%@page import="servlets.servlet"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="Managers.Medico"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../Estilos/estilo.css">
        <title>Buscar Medico</title>
        <%! Medico medico = new Medico();
            Especialidad especialidad = new Especialidad();
            Examen examen = new Examen();
        %>
        <%!DataSource dataSource;%>
        <%
            try {

                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                dataSource = (DataSource) envContext.lookup("jdbc/Hospital");
            } catch (NamingException exe) {
            }
            String nombre = request.getParameter("buscarNombre");
            String query = "SELECT  medico_tiene_especialidad.Especialidad_Titulo ,Medico.Usuario_codigo, Medico.nombre, Medico.hora_inicio, Medico.hora_salida, Medico.email, Medico.DPI, Medico.numero_colegiado, "
                    + "Medico.fecha_debut FROM Medico INNER JOIN  medico_tiene_especialidad ON medico_tiene_especialidad.Medico_Usuario_codigo = Medico.Usuario_codigo WHERE Medico.nombre LIKE '%" + nombre + "%'";

        %>
    </head>
    <body>
        <div class="form__principal">
            <form method="post" enctype="multipart/form-data" action="../cita">
                <div class="envoltura">
                    <div class="super__titulo">
                        <h1>Agendar Cita</h1>
                    </div>
                    <div class="formulario">

                        <div class="entradas">
                            <label> Codigo de Cita: </label>
                            <input type="text" class="input" name="codigoCita" id="codigoCita" requiered>
                        </div>
                        <div class="entradas">
                            <label> Codigo de Médico: </label>
                            <input type="text" class="input" name="codigo" id="codigo" requiered>
                        </div>
                        <div class="entradas">
                            <label> Especialidad: </label>
                            <input type="text" class="input" name="especialidad" id="especialidad" requiered>
                        </div>
                        <div class="entradas">
                            <label> Nombre: </label>
                            <input type="text" class="input" name="nombre" id="nombre">
                        </div>
                        <div class="entradas">
                            <label> Fecha: </label>
                            <input type="date" class="input" name="fecha" id="fecha" requiered>
                        </div>
                        <div class="entradas">
                            <label> Hora: </label>
                            <input type="time" class="input" name="hora" id="hora" requiered>
                        </div>

                        <div class="enviar">
                            <input type="button" onclick="mostrar()" class="boton" value="Cita para examen">
                            <label> Enviar </label>
                            <input type="submit" name="boton" class="boton">
                        </div>

                    </div>
                </div>
                <div id="body">
                    <div class="subapartado" id="examen">
                        <div class="titulo">
                            <p class="titulo">Establecer examen</p>                    
                        </div>
                        <div class="info">

                            <%                        LinkedList<String> examenes = examen.imprimirTabla(dataSource);
                                for (int i = 0; i < examenes.size(); i++) {
                                    out.print(examenes.get(i));
                                }
                            %>
                        </div>
                        <div class="info">

                            <div class="entradas">
                                <label> Codigo de examen: </label>
                                <input type="text" class="input" name="codigoExamen" id="codigoExamen" requiered>
                            </div>

                            <div class="entradas" id="orden">
                                <label>Adjuntar orden:</label>
                                <input type="file" class="input" name="ordenArchivo" id="ordenArchivo">
                            </div>

                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div id="body">

            <div class="subapartado">

                <div class="titulo">
                    <p class="titulo">Buscar por nombre:</p>
                </div>

                <div class="info">

                    <form action="encontrarMedico.jsp" method="POST">
                        <input type="text" class="input" name="buscarNombre">
                        <input type="submit">


                        <%      if (medico.imprimirMedicos(dataSource, query) != null) {
                                LinkedList<String> medicos = medico.imprimirMedicos(dataSource, query);
                                for (int i = 0; i < medicos.size(); i++) {
                                    out.print(medicos.get(i));
                                }
                            }
                        %>

                    </form>

                </div>

            </div>

            <div class="subapartado" id="control">

                <div class="titulo">
                    <p class="titulo">Buscar por especialidad:</p>
                </div>

                <div class="info">
                    <form method="post" action="encontrarMedico.jsp">
                        <label> Especialidades: </label>
                        <div class="selectBox" onclick="showCheckboxes()" required>
                            <select>
                                <option>Seleccione una opcion</option>
                            </select>
                            <div class="overSelect"></div>
                        </div>
                        <div id="checkboxes">
                            <%String query1 = "SELECT * FROM Especialidad";
                                LinkedList<String> especialidades = new LinkedList<>();
                                try (PreparedStatement estado = dataSource.getConnection().prepareStatement(query1);
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
                            <input type="submit">
                        </div>

                    </form>
                    <div>
                        <%
                            LinkedList<String> medicos = medico.imprimirMedicos(dataSource, especialidad.armarQuery(request, dataSource));
                            if (medicos != null) {
                                for (int i = 0; i < medicos.size(); i++) {
                                    out.print(medicos.get(i));
                                }
                            }%>
                    </div>
                </div>
            </div>

            <!--
                        <div class="subapartado">
            
                            <div class="titulo">
                                <p class="titulo">Keyquotes</p>
                            </div>
            
                            <div class="info">
                                <p class="info">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptatibus, sed, temporibus, veritatis quas consequuntur quaerat repellendus iusto quis itaque similique illo suscipit adipisci vel quasi expedita. Asperiores, culpa, veniam inventore deserunt at mollitia nisi dolores repellat dignissimos voluptate beatae pariatur quibusdam ipsam est assumenda eveniet minus voluptates cupiditate modi odit!</p>
                            </div>
            
                        </div>
            -->


        </div>
        <script>
            var expandido = false;
            var divisor = document.getElementById("examen");
            var extra = document.getElementById("orden");
            var table = document.getElementById('table');
            var tablaExamenes = document.getElementById('tablaExamenes');
            divisor.style.display = "none";
            extra.style.display = "none";

            for (var i = 1; i < table.rows.length; i++)
            {
                table.rows[i].onclick = function ()
                {
                    document.getElementById("codigo").value = this.cells[1].innerHTML;
                    document.getElementById("especialidad").value = this.cells[0].innerHTML;
                    document.getElementById("nombre").value = this.cells[2].innerHTML;
                };
            }

            for (var i = 1; i < tablaExamenes.rows.length; i++)
            {
                tablaExamenes.rows[i].onclick = function ()
                {
                    document.getElementById("codigoExamen").value = this.cells[0].innerHTML;
                    if (this.cells[3].innerHTML === "true") {
                        extra.style.display = "block";
                        document.getElementById("ordenArchivo").required = false;
                    } else {
                        extra.style.display = "none";
                        document.getElementById("ordenArchivo").required = true;
                    }
                };
            }

            function showCheckboxes() {
                var checkboxes = document.getElementById("checkboxes");
                if (!expandido) {
                    checkboxes.style.display = "block";
                    expandido = true;
                } else {
                    checkboxes.style.display = "none";
                    expandido = false;
                }
            }


            function mostrar() {
                if (divisor.style.display === "none") {
                    divisor.style.display = "block";
                } else {
                    divisor.style.display = "none";
                }
            }
        </script>
    </body>
</html>

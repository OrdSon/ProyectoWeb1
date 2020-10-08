<%-- 
    Document   : registrarReporte
    Created on : 8/10/2020, 08:50:14
    Author     : samuelson
--%>

<%@page import="Managers.Orden"%>
<%@page import="Managers.Examen"%>
<%@page import="Managers.Reporte"%>
<%@page import="Managers.Cita"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.util.LinkedList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../Estilos/estilo.css">
        <%!DataSource dataSource;
            Reporte reporte = new Reporte();
            Examen examen = new Examen();
            Orden orden = new Orden();
        %>
        <%
            Cita cita = new Cita();
            LinkedList<String> datos = new LinkedList<>();

            try {

                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                dataSource = (DataSource) envContext.lookup("jdbc/Hospital");

            } catch (NamingException exe) {
            }
        %>
        <title>reporte</title>
    </head>
    <body>
        <div class="envoltura">
            <div class="super__titulo">
                <h1>Registrar Resultados</h1>
            </div>
            <div class="formulario">
                <form method="post" action="../Registros/resultadoRegistrado.jsp">
                    <div class="entradas">
                        <label> Codigo: </label>
                        <input type="number" class="input" name="codigo" id="codigo">
                    </div>
                    <div class="entradas">
                        <label> Reporte: </label>
                        <input type="text" class="input" name="reporte" id="reporte">
                    </div>
                    <div class="entradas">
                        <label> Examen: </label>
                        <input type="text" class="input" name="examen" id="examen">
                    </div>
                    <div class="entradas">
                        <label> Laboratorista: </label>
                        <input type="text" class="input" name="laboratorista">
                    </div>
                    <div class="entradas">
                        <label> Orden </label>
                        <input type="text" class="input" name="orden" id="cita">
                    </div>

                    <div class="enviar">
                        <label> Enviar </label>
                        <input type="submit" class="boton"  id="boton">
                    </div>

                </form>
            </div>
        </div>
        <div id="body">

            <div class="subapartado">

                <div class="titulo">
                    <p class="titulo">Reportes </p>
                </div>

                <div class="info">
                    <% LinkedList<String> reportes = reporte.imprimirReportes(dataSource);
                        for (int i = 0; i < reportes.size(); i++) {
                            out.print(reportes.get(i));
                        }
                    %>
                </div>

            </div>
            <div class="subapartado">

                <div class="titulo">
                    <p class="titulo">Examenes </p>
                </div>

                <div class="info">
                    <% LinkedList<String> examenes = examen.imprimirTabla(dataSource);
                        for (int i = 0; i < examenes.size(); i++) {
                            out.print(examenes.get(i));
                        }
                    %>
                </div>

            </div>
            <div class="subapartado">

                <div class="titulo">
                    <p class="titulo">Ordenes </p>
                </div>

                <div class="info">
                    <% LinkedList<String> ordenes = orden.imprimirOrdenes(dataSource);
                        for (int i = 0; i < ordenes.size(); i++) {
                            out.print(ordenes.get(i));
                        }
                    %>
                </div>

            </div>



        </div>
        <script>
            var table = document.getElementById('tablaExamenes');
            for (var i = 1; i < table.rows.length; i++)
            {
                table.rows[i].onclick = function ()
                {
                    document.getElementById("examen").value = this.cells[0].innerHTML;
                };
            }
            var tablaReportes = document.getElementById('tablaReportes');
            for (var i = 1; i < table.rows.length; i++)
            {
                tablaReportes.rows[i].onclick = function ()
                {
                    document.getElementById("reporte").value = this.cells[0].innerHTML;
                };
            }
            var tableOrdenes = document.getElementById('tablaOrdenes');
            for (var i = 1; i < table.rows.length; i++)
            {
                tablaOrdenes.rows[i].onclick = function ()
                {
                    document.getElementById("orden").value = this.cells[0].innerHTML;
                };
            }

        </script>
    </body>
    <%dataSource.getConnection().close();%>
</html>

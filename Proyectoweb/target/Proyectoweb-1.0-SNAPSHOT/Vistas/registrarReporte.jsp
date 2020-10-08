<%-- 
    Document   : registrarReporte
    Created on : 8/10/2020, 08:50:14
    Author     : samuelson
--%>

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
        <link rel="stylesheet" href="../Estilos/estiloRegistrarMedico.css">
        <%!DataSource dataSource;%>
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
            <div class="titulo">
                <h1>Registrar Reporte</h1>
            </div>
            <div class="formulario">
                <form method="post" action="../Registros/reporteRegistrado.jsp">
                    <div class="entradas">
                        <label> Codigo: </label>
                        <input type="text" class="input" name="codigo">
                    </div>
                    <div class="entradas">
                        <label> Descripcion: </label>
                        <textarea class="textarea" name="descripcion"></textarea>

                    </div>
                    <div class="entradas">
                        <label> Cita: </label>
                        <input type="text" class="input" name="cita" id="cita">
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
                    <p class="titulo">Citas </p>
                </div>

                <div class="info">
                    <% LinkedList<String> citas = cita.imprimirCitas(dataSource);
                        for (int i = 0; i < citas.size(); i++) {
                            out.print(citas.get(i));
                        }
                    %>
                </div>

            </div>




        </div>
        <script>
            var table = document.getElementById('table');
            for (var i = 1; i < table.rows.length; i++)
            {
                table.rows[i].onclick = function ()
                {
                    document.getElementById("cita").value = this.cells[0].innerHTML;
                };
            }
        </script>
    </body>
    <%dataSource.getConnection().close();%>
</html>

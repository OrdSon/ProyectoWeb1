<%-- 
    Document   : reportesAdmin
    Created on : 8/10/2020, 13:26:12
    Author     : samuelson
--%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.Context"%>
<%@page import="Managers.Administrador"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.util.LinkedList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%!DataSource dataSource;%>
        <%
            Administrador administrador = new Administrador();
            LinkedList<String> datos = new LinkedList<>();

            try {

                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                dataSource = (DataSource) envContext.lookup("jdbc/Hospital");
                datos = administrador.datos(dataSource, request.getSession().getAttribute("codigo").toString());
            } catch (NamingException exe) {
            }%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../Estilos/estilo.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div id="body">

            <div class="subapartado">

                <div class="titulo">
                    <p class="titulo">Reportes </p>
                </div>

                <div class="info">
                    <%  LinkedList<String> lista = administrador.verReportes(1, dataSource);
                        for (int i = 0; i < lista.size(); i++) {
                            out.print(lista.get(i));
                        }
                    %>
                </div>

            </div>
            <div class="subapartado">

                <div class="titulo">
                    <p class="titulo">Reportes </p>
                </div>

                <div class="info">
                    <% lista = administrador.verReportes(2, dataSource);
                        for (int i = 0; i < lista.size(); i++) {
                            out.print(lista.get(i));
                        }
                    %>                </div>

            </div>
            <div class="subapartado">

                <div class="titulo">
                    <p class="titulo">Reportes </p>
                </div>

                <div class="info">
                    <% lista = administrador.verReportes(3, dataSource);
                        for (int i = 0; i < lista.size(); i++) {
                            out.print(lista.get(i));
                        }
                    %>                </div>

            </div>
            <div class="subapartado">

                <div class="titulo">
                    <p class="titulo">Reportes </p>
                </div>
                <% lista = administrador.verReportes(4, dataSource);
                        for (int i = 0; i < lista.size(); i++) {
                            out.print(lista.get(i));
                        }
                %>                <div class="info">

                </div>

            </div>
        </div>
                <% dataSource.getConnection().close();%>
    </body>
</html>

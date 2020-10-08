<%-- 
    Document   : reporteRegistrado
    Created on : 8/10/2020, 09:47:18
    Author     : samuelson
--%>

<%@page import="Managers.Reporte"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Managers.Cita"%>
<%@page import="javax.sql.DataSource"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>reporte registrado</title>
        <%!DataSource dataSource;
        LinkedList<String>  datos = new LinkedList<>();%>
        <%
            Reporte reporte = new Reporte();
            LinkedList<String> datos = new LinkedList<>();

            try {

                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                dataSource = (DataSource) envContext.lookup("jdbc/Hospital");
                
                datos.add(request.getParameter("codigo"));
                datos.add(request.getParameter("reporte"));
                datos.add(request.getParameter("examen"));
                datos.add(request.getParameter("laboratorista"));
                datos.add(request.getParameter("orden"));
                
                reporte.crear(dataSource, datos);
            } catch (NamingException exe) {
            }
        %>
    </head>
    <body>
        <h1>Reporte registrado</h1>
    </body>
    <% dataSource.getConnection().close(); %>
</html>

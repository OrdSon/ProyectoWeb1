<%-- 
    Document   : resultadoRegistrado
    Created on : 8/10/2020, 10:59:37
    Author     : samuelson
--%>

<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.LinkedList"%>
<%@page import="javax.naming.Context"%>
%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="Managers.Resultado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Resultado registrado</title>
        <%!DataSource dataSource;%>
        LinkedList<String>  datos = new LinkedList<>();%>
        <%
            Resultado resultado = new Resultado();
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
                
                resultado.crear(dataSource, datos);
            } catch (NamingException exe) {
            }
        %>
    </head>
    <body>
        <h1>Resultado registrado</h1>
    </body>
</html>

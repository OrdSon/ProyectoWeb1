<%-- 
    Document   : examenRegistrado
    Created on : 4/10/2020, 21:59:24
    Author     : samuelson
--%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Managers.Examen"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        codigo, formato, orden, nombre, descripcion
        <%  Examen examen = new Examen();
            LinkedList<String> datos = new LinkedList<>();
            DataSource dataSource;
            try {

                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                dataSource = (DataSource) envContext.lookup("jdbc/Hospital");
                datos.add(request.getParameter("codigo"));
                datos.add(request.getParameter("formato"));
                datos.add(request.getParameter("orden"));
                datos.add(request.getParameter("nombre"));
                datos.add(request.getParameter("descripcion"));
                if (examen.crear(datos, dataSource) == false) {
                    response.sendRedirect("error.html");
                } else {
                    response.getWriter().print("");
                }
            } catch (NamingException exe) {
            }


        %>
    </head>
    <body>
        <h1>Examen Registrado!</h1>
    </body>
</html>

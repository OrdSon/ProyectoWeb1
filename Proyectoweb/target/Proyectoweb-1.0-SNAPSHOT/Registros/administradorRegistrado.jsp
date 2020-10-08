<%-- 
    Document   : administradorRegistrado
    Created on : 4/10/2020, 21:14:49
    Author     : samuelson
--%>

<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Managers.Administrador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%  Administrador administrador = new Administrador();
        LinkedList<String> datos = new LinkedList<>();
        DataSource dataSource;
        try {

            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/Hospital");
            datos.add(request.getParameter("codigo"));
            datos.add(request.getParameter("pass"));
            datos.add(request.getParameter("nombre"));
            datos.add(request.getParameter("dpi"));
            if (administrador.crear(datos, dataSource) == false) {
                response.sendRedirect("error.html");
            } else {
                response.getWriter().print("");
            }
            dataSource.getConnection().close();
        } catch (NamingException exe) {
        }


    %>
    <body>
        <h1>Administrador Registrado!</h1>
    </body>
</html>

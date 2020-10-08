<%-- 
    Document   : consultaRegistrada
    Created on : 4/10/2020, 20:53:28
    Author     : samuelson
--%>

<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Managers.Consulta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%  Consulta consulta = new Consulta();
            LinkedList<String> datos = new LinkedList<>();
            DataSource dataSource;
            try {

                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                dataSource = (DataSource) envContext.lookup("jdbc/Hospital");
                if (consulta.validarEInsertar(request, dataSource, request.getParameter("precio")) == false) {
                    response.sendRedirect("error.html");
                } else {
                    response.getWriter().print("");
                }
                dataSource.getConnection().close(); 
            } catch (NamingException exe) {
            }


        %>
        <h1>CONSULTA REGISTRADA</h1>
    </body>
</html>

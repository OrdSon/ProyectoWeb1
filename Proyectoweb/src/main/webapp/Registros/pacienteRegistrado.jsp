<%-- 
    Document   : pacienteRegistrado
    Created on : 4/10/2020, 20:39:41
    Author     : samuelson
--%>

<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Managers.Paciente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    Usuario_codigo, Usuario_contraseña, nombre, DPI, email, telefono, birth, sexo, peso, tipo_sangre
    <%  Paciente paciente = new Paciente();
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
                datos.add(request.getParameter("email"));
                datos.add(request.getParameter("telefono"));
                datos.add(request.getParameter("fecha"));
                datos.add(request.getParameter("sexo"));
                datos.add(request.getParameter("peso"));
                datos.add(request.getParameter("sangre"));
                if (paciente.crear(datos, dataSource) == false) {
                    response.sendRedirect("error.html");
                } else {
                    response.getWriter().print("");
                }
            } catch (NamingException exe) {
            }


        %>
    <h1>Paciente registrado!</h1>
    </body>
</html>

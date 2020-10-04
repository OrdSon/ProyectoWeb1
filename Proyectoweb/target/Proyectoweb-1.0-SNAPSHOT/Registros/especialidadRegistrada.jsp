<%-- 
    Document   : especialidadRegistrada
    Created on : 4/10/2020, 00:20:20
    Author     : samuelson
--%>

<%@page import="Managers.Laboratorista"%>
<%@page import="Managers.Especialidad"%>
<%@page import="java.util.LinkedList"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.Context"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Especialidad Registrada</title>
    </head>
    <body>

        <%
            Especialidad especialidad = new Especialidad();
            LinkedList<String> datos = new LinkedList<>();
            DataSource dataSource;
            try {

                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                dataSource = (DataSource) envContext.lookup("jdbc/Hospital");

                if (especialidad.crear(request.getParameter("titulo"), dataSource) == false) {
                    response.sendRedirect("error.html");
                } else {
                    response.getWriter().print("");
                }
            } catch (NamingException exe) {
            }



        %>
        <div class="envoltura">
            <div class="titulo">
                <h1>Especialidad agregada!</h1>
            </div>
            <div class="enviar">
                <form>
                    <input type="submit" action="../Html/agregarEspecialidad.html" value="Volver" class="boton">
                </form>

            </div>
        </div>
    </body>
</html>

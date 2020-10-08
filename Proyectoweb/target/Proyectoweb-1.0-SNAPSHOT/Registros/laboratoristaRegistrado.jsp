<%-- 
    Document   : laboratoristaRegistrado
    Created on : 3/10/2020, 00:48:44
    Author     : samuelson
--%>

<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Managers.Laboratorista"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <style>
    <jsp:include page="../Estilos/estiloRegistroExitoso.css"/>
    </style>
    <head>
        <title>Registrar Laboratorista</title>
        
        

    </head>
    <body>
        <%  Laboratorista laboratorista = new Laboratorista();
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
                datos.add(request.getParameter("registro"));
                datos.add(request.getParameter("fecha"));
                if (laboratorista.crear(datos, dataSource) == false) {
                    response.sendRedirect("error.html");
                } else {
                    response.getWriter().print("");
                }
                dataSource.getConnection().close(); 
            } catch (NamingException exe) {
            }    
        %>
        
        <div class="envoltura">
            <div class="titulo">
                <h1>Usuario creado satisfactoriamente!</h1>
            </div>
            <div class="enviar">
                <form>
                    <input type="submit" action="registrarLaboratorista.html" value="Volver" class="boton">
                </form>

            </div>
        </div>
    </body>
</html>

<%-- 
    Document   : medicoRegistrado
    Created on : 4/10/2020, 02:08:31
    Author     : samuelson
--%>

<%@page import="Managers.EspecialidadMedico"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Managers.Medico"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Medico Registrado</title>
    </head>
    <body>
        
        <%
        Medico medico = new Medico();
        EspecialidadMedico especialidadMedico = new EspecialidadMedico();
            LinkedList<String> datos = new LinkedList<>();
            DataSource dataSource;
            try {

                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                dataSource = (DataSource) envContext.lookup("jdbc/Hospital");
                datos.add(request.getParameter("codigo"));
                datos.add(request.getParameter("pass"));
                datos.add(request.getParameter("nombre"));
                datos.add(request.getParameter("horaInicio"));
                datos.add(request.getParameter("horaSalida"));
                datos.add(request.getParameter("email"));
                datos.add(request.getParameter("telefono"));
                datos.add(request.getParameter("dpi"));
                datos.add(request.getParameter("colegiado"));
                datos.add(request.getParameter("fecha"));
                System.out.println(request.getParameter("Neurologia")+" ESPECIALIDAD nueva");
                if(especialidadMedico.validarEInsertar(request, dataSource, request.getParameter("codigo")) == false){
                    response.sendRedirect("error.html");
                }
                else if (medico.crear(datos, dataSource) == false) {
                    response.sendRedirect("error.html");
                } 
                
            } catch (NamingException exe) {
            }
        %>
        <h1>Medico registrado!</h1>
    </body>
</html>

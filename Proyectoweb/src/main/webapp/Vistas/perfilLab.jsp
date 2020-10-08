<%-- 
    Document   : perfilAdmin
    Created on : 8/10/2020, 12:57:54
    Author     : samuelson
--%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="java.util.LinkedList"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="Managers.Administrador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../Estilos/estiloPerfil.css">
        <%!DataSource dataSource;%>
        <%
            Administrador administrador = new Administrador();
            LinkedList<String> datos = new LinkedList<>();

            try {

                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                dataSource = (DataSource) envContext.lookup("jdbc/Hospital");
                datos = administrador.datos(dataSource, request.getSession().getAttribute("codigo").toString());
                dataSource.getConnection().close();
            } catch (NamingException exe) {
            }
        %>
        <title>JSP Page</title>
    </head>
    <body>
        <div class="envoltura">
            <div class="titulo">
                <h1>Administrador</h1>
            </div>
            <div class="formulario">
                <div class="entradas">
                    <label> Nombre </label>
                    <label name="nombre"><%= datos.get(3)%> </label>
                </div>
                <div class="entradas">
                    <label> Codigo </label>
                    <label name="codigo"><%= datos.get(4)%> </label>
                </div>

                <div class="enviar">
                    <label> Acciones: </label>
                    <form action="reportesAdmin.jsp" method="post">
                        <input type="submit" class="boton">
                    </form>
                    <form action="registrarPaciente.html" method="post">
                        <input type="submit" class="boton" value="Registrar Paciente">
                    </form>
                    <form action="registrarMedico.jsp" method="post">
                        <input type="submit" class="boton" value="Registrar Medico">
                    </form>
                    <form action="registrarLaboratorista.html" method="post">
                        <input type="submit" class="boton" value="Registrar Laboratorista">
                    </form>
                    <form action="registrarExamen.html" method="post">
                        <input type="submit" class="boton" value="Registrar Examen">
                    </form>
                    <form action="registrarConsulta.jsp" method="post">
                        <input type="submit" class="boton" value="Registrar consulta">
                    </form>
                    <form action="registrarAdministrador.html" method="post">
                        <input type="submit" class="boton" value="Registrar Administrador">
                    </form>
                </div>


            </div>
    </body>
</html>

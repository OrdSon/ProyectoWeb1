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
                <h1>Paciente</h1>
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
                    <form action="reportesPaciente.jsp" method="post">
                        <input type="submit" class="boton" value="Ver reportes">
                    </form>
         
                </div>


            </div>
    </body>
</html>

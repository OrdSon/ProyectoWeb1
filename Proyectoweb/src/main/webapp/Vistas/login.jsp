<%-- 
    Document   : login
    Created on : 8/10/2020, 11:46:44
    Author     : samuelson
--%>

<%@page import="Managers.Administrador"%>
<%@page import="Managers.Usuario"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.util.LinkedList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrar</title>
        <link rel="stylesheet" href="../Estilos/estiloLogin.css">
    </head>
    <%!DataSource dataSource;
        LinkedList<String> datos = new LinkedList<>();%>
    <%
        Usuario usuario = new Usuario();
        
        try {
            
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/Hospital");
            String codigo = request.getParameter("codigo");
            String pass = request.getParameter("password");
            if (codigo != null && pass != null) {
                datos = usuario.comprobarUsuario(dataSource, codigo, pass);
                if (!datos.isEmpty()) {
                    request.getSession().setAttribute("codigo", datos.get(0));
                    request.getSession().setAttribute("tipo", datos.get(2));
                    String tipo = request.getSession().getAttribute("tipo").toString();
                    if (tipo.equals("Administrador")) {
                        RequestDispatcher dispatcher = request.getRequestDispatcher("perfilAdmin.jsp");
                        dispatcher.forward(request, response);
                    } else if (tipo.equals("Laboratorista")) {
                        RequestDispatcher dispatcher = request.getRequestDispatcher("perfilLab.jsp");
                        dispatcher.forward(request, response);
                    } else if (tipo.equals("Paciente")) {
                        RequestDispatcher dispatcher = request.getRequestDispatcher("perfilPaciente.jsp");
                        dispatcher.forward(request, response);
                    } else if (tipo.equals("Medico")) {
                        RequestDispatcher dispatcher = request.getRequestDispatcher("perfilMedico.jsp");
                        dispatcher.forward(request, response);
                    }
                }
            }
        } catch (NamingException exe) {
        }
    %>
    <body>
        <div class="envoltura">
            <div class="titulo">
                <h1>Ingresar</h1>
            </div>
            <div class="formulario">
                <form method="post" action="login.jsp">
                    <div class="entradas">
                        <label> Codigo: </label>
                        <input type="text" class="input" name="codigo">
                    </div>
                    <div class="entradas">
                        <label> Contraseña: </label>
                        <input type="password" class="input" name="password">
                    </div>
                    <div class="enviar">
                        <input type="submit" value="Registrar" class="boton">
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>

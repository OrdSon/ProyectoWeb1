<%-- 
    Document   : citaRegistrada
    Created on : 7/10/2020, 13:45:57
    Author     : samuelson
--%>

<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="Managers.Examen"%>
<%@page import="java.util.LinkedList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%!Examen examen = new Examen();
            DataSource dataSource;%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consluta Registrada</title>
    </head>
    <body>
        <%try {

                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:/comp/env");
                dataSource = (DataSource) envContext.lookup("jdbc/Hospital");
            } catch (NamingException exe) {
            }
            if (request.getParameter("tipo").equals("examen")) {%>

        <div class="envoltura">
            <div class="titulo">
                <h1>Elegir examen</h1>
            </div>
            <div class="formulario">
                <div class="entradas">
                    <div class="custom__select">
                        <select name="tipo">
                            <%  LinkedList<String> opciones = examen.obtenerOpciones(dataSource);
                                for (int i = 0; i < opciones.size(); i++) {
                                    out.print(opciones.get(i));
                                }
                            %>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <% } else if (request.getParameter("tipo").equals("consulta")) {%>



        <div class="envoltura">
            <div class="titulo">
                <h1>Registro</h1>
            </div>
            <div class="formulario">
                <div class="entradas">
                    <label>  </label>
                </div>
                <div class="entradas">
                    <label> </label>
                </div>
                <div class="entradas">
                    <label>  </label>
                </div>
                <div class="entradas">
                    <label> </label>
                </div>
                <div class="entradas">
                    <label> </label>
                </div>
                <div class="entradas">
                    <label> </label>
                </div>
                <div class="entradas">
                    <label> </label>
                </div>
                <div class="enviar">
                    <input type="submit" value="Registrar" class="boton">
                </div>
            </div>
        </div>
        <%}%>
    </body>
</html>

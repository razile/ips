<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language ="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.text.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Locale"%>
<%@page import="com.ips.database.*"%>
<%@ page buffer="16kb"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<
<html>  
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
    </head>  
    <body>
   
     <%  
      String area = request.getParameter("accountId");  
     String ftype = request.getParameter("accountId");  
        response.setContentType("text/html");  
        response.setHeader("Cache-Control", "no-cache");  
        Connection con = null;
        try {  
            String buffer = "<div>";  
          	con = FactorDBService.getInstance().openConnection();
            //Connection con = ConnectionManager.getConnection();  
            Statement stmt = con.createStatement();  
            String query = "Select f.Flat_No,a.Building_Name,t.Flat_Type from tblflat f,tblarea a,tblflattype t where f.Area_Code=a.Area_Code AND f.Flat_Code=t.Flat_Code AND f.Status ='"+ftype+"' AND Area_Name='" + area + "'";  
            System.out.println(query);  
            ResultSet rs = stmt.executeQuery(query);  
            while (rs.next()) {  
                String flatNo = rs.getString("Flat_No");  
                String flattype = rs.getString("Flat_Type");  
                String bname = rs.getString("Building_Name");  
                buffer += "<option value='" + flatNo + "::" + flattype + "::" + bname + "'>" + flatNo + "::" + flattype + "::" + bname + "</option>";  
            }  
            buffer = buffer + "</select>";  
            response.getWriter().println(buffer);  
        } catch (Exception e) {  
            response.getWriter().println(e);  
        }  finally {
        	FactorDBService.getInstance().releaseConnection(con);
        }
        %>  
    </body>  
</html>  

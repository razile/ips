<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.io.*" %>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*"%>
<%@ page import="java.text.NumberFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
     <table border=0 cellpadding=0 cellspacing=0>
     <tr><td style="height:60px"></td></tr>
     
 <%! String driverName = "net.sourceforge.jtds.jdbc.Driver";%>

<%@ include file="connection.jsp" %>
 
 <%!
 public String colorMe (String stat){
	 String color;
	 
	 if (stat.equals("Current")){
        	color = "<span style='color:black'>"+stat+"</span>";
	 }else if (stat.equals("Due")){
	        color = "<span style='color:green'>"+stat+"</span>";
	 }else if (stat.equals("Delinquent")){
		 color = "<span style='color:red'>"+stat+"</span>";
	 }else if (stat.equals("Overdue")){
	        color = "<span style='color:orange'>"+stat+"</span>";
	 }else {
	        color = "<span style='color:black'>"+stat+"</span>";
	 }	      
	 return color;
	 }

	 %>
 
 
 
 
     
 <% String pid = request.getParameter("pid");
    String aid = request.getParameter("str");
 int payerid=0;
 String currency="";
 String company="";
 String companyD="";
 String companyDOther="";
Connection con = null;
ResultSet rs =null;
PreparedStatement ps = null;
CallableStatement cs = null;
try {
	Class.forName(driverName);
 con = DriverManager.getConnection(url,user,psw);
 String sql ="select currencytype from PayersAccounts where sysid = " + aid;
  ps = con.prepareStatement(sql);
 rs = ps.executeQuery();
 while (rs.next())
 {
	currency = rs.getString("currencytype"); 
 }
 if (currency == null || currency=="")
           {currency="CAD";}
 if (pid !=null && pid.length()>0)
   {
    	payerid = Integer.parseInt(pid);
   }
 else
 {
	    payerid=Integer.parseInt(session.getAttribute("pyid").toString()); 
 }
 if (currency !=null)
 {
	 if (currency.contains("CAD")){
		 companyD = "CAD";
		 companyDOther = "USD";
		 company="01";
	 }
	 else if (currency.contains("USD")){
		 companyD = "USD";
		 companyDOther = "CAD";
		 company="00";
	 } 
 } 
    %>
   <div id="maincurrency" style="width:1000px"><code>
<% 
    cs = con.prepareCall("{call Get_Invoices(?)}");
    //int pid =Integer.parseInt(String.valueOf(payerid));
    cs.setInt(1, payerid);
    //cs.setString(2, company);
    //cs.registerOutParameter(2, Types.VARCHAR);
    //cs.execute();
    //String str = cs.getString(1);
    int counter1=0;
    
       int loop =0;
       int loop1=0;
        rs = cs.executeQuery();
        int counter=0;
        while (rs.next()) 
        { if (loop==0){%></code>
               <tr><td colspan=2 ><h3>     
                <Label id="CurrencyInvoice" style="text-decoration:underline;color:#d06200"><%=companyD%> Factures</Label>
                </h3></td></tr>
               <tr>
               <td style="width:250px"><h6>Fournisseur</h6></td>
                <td style="width:150px"><h6>N<sup>o</sup> de bon de commande</h6></td>
               <td style="width:150px"><h6>Facture Nombre</h6></td>
               <td style="width:150px"><h6>de jours impay&egrave;s</h6></td>
               <td style="width:100px"><h6>&Ecirc;tat</h6></td>
               <td style="width:150px"><h6>Montant</h6></td>
               <td style="width:150px" class="AccountDependent AccountNoSelect"><div class="AccountNoSelect"><h6>Montant du paiement</h6></div></td>
               <td style="width:150px" class="AccountDependent AccountNoSelect"><h6>Commentaires</h6></td>
               <td style="width:150px" class="AccountDependent AccountNoSelect"><h6>Confirmer</h6></td>

              </tr>
   <code>      <%}
        loop=loop+1; 
        
        String invcurrency = rs.getString(7);
        if (invcurrency !=null)
        	invcurrency = invcurrency.trim();
        if ((invcurrency.equals("01") && company.equals("01"))
        		||(!invcurrency.equals("01") && !company.equals("01")))
        {counter1=counter1+1;
        %></code>
     <tr>   
            <td><h6 style="font-size:1.7em;"><%= rs.getString(2)%></h6></td>
       <td><h6><%= rs.getString(9)%></h6></td>
        <td><h6><%= rs.getString(1)%></h6></td>
        <td><h6><%   Date currentDate = new Date();
                  Date openDate = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(rs.getString(6));
                  long daysms =  Math.abs(currentDate.getTime() - openDate.getTime());
                  long ONE_DAY = 1000 * 60 * 60 * 24;
                  int days = Math.round(daysms /ONE_DAY);
                  %>
        <%= days%></h6></td>
        <td><h6><%= colorMe(rs.getString(8))%></h6></td>
        <td class="h6right"><% //DecimalFormat decim = new DecimalFormat("0.00");
        //String price2 = decim.format(Double.parseDouble(rs.getString(3)));
        NumberFormat fmt = NumberFormat.getCurrencyInstance(Locale.US);
        Double d = Double.parseDouble(rs.getString(3)) ;
		   String price2 = fmt.format(d);
      
        %><%=price2 %></h6></td>
     <!--   <td><h6>$<label id="discount" ></label></h6></td>-->  
        <td class="AccountDependent AccountNoSelect"><h6>$<input type=text style="width:80px" class="pay rightJustified" name="paymentamount<%=counter%>"></h6></td>
        <td class="AccountDependent AccountNoSelect"><h6><input type=text style="width:120px"  name="paymentComment<%=counter%>"></h6></td>
        
        <td class="AccountDependent AccountNoSelect"><h6><input type=checkbox  class="paycheck" name="paycheck<%=counter%>"></h6></td>
        <td><input type="hidden" name="invoiceid<%=counter%>" id="invoiceid<%=counter%>" value=<%=rs.getString(4) %> >
        <input type="hidden" name="invoiceNumber<%=counter%>" id="invoiceNumber<%=counter%>" value=<%=rs.getString(1) %> ></td>
        <td><input type="hidden" name="clientid<%=counter%>" id="clientid<%=counter%>" value=<%=rs.getString(5) %> >
        <input type="hidden" name="amount<%=counter%>" id="amount<%=counter%>" value=<%=rs.getString(3) %> >
        
        </td>

        </tr>
        <tr><td style="height:4px"></td></tr>
     <code>  <%} counter=counter+1;
        }  if(counter1==0)
    {%> 
    
    <tr><td colspan=5 >     
              <span class="AlertRed">Nous n'avons trouv&#233; aucune facture en devise am&#233;ricaine <%=companyD%> currency.
              </span></td></tr>
       
    <%} %>
        
         
   </div>
   <div id="secondarycurrency" style="visibility:hidden;width:1000px;">
    <!-- second round -->
    <% counter1=0;
        cs = con.prepareCall("{call Get_Invoices(?)}");
        cs.setInt(1, payerid);
        rs = cs.executeQuery();
    //rs.beforeFirst(); 
    
    while (rs.next()){
    	String invcurrency = rs.getString(7);
        if (invcurrency !=null)
        	invcurrency = invcurrency.trim();
    if ((invcurrency.equals("01") && !company.equals("01"))
		||(!invcurrency.equals("01") && company.equals("01")))
{
 if (loop1==0){ %><tr class="secondarycurrency"><td colspan=2 ><h3>     
                <Label id="CurrencyInvoice" style="text-decoration:underline;color:#d06200"><%=companyDOther%> Invoices</Label>
                </h3></td></tr>
     <%} loop1=loop1+1;
     counter1=counter1+1;
     %>
     <tr  class="secondarycurrency">   
            <td><h6 style="font-size:1.7em;"><%= rs.getString(2)%></h6></td>
        <td><h6><%= rs.getString(9)%></h6></td>
        <td><h6><%= rs.getString(1)%></h6></td>
        <td><h6><%   Date currentDate = new Date();
                  Date openDate = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(rs.getString(6));
                  long daysms =  Math.abs(currentDate.getTime() - openDate.getTime());
                  long ONE_DAY = 1000 * 60 * 60 * 24;
                  int days = Math.round(daysms /ONE_DAY);
                  %>
        <%= days%></h6></td>
      <td>  <h6><%= colorMe(rs.getString(8))%></h6></td>
        <td class="h6right">$<% DecimalFormat decim = new DecimalFormat("0.00");
        String price2 = String.format("%,14.2f",Double.parseDouble(rs.getString(3)));

        %><%=price2 %></td>
      
     <!--   <td><h6>$<label id="discount" ></label></h6></td>-->  
        <td class="AccountDependent"><h6>$<input type=text style="width:80px" class="pay rightJustified" name="paymentamount<%=counter%>"></h6></td>
        <td class="AccountDependent"><h6><input type=text style="width:120px"  name="paymentComment<%=counter%>"></h6></td>
        
        <td class="AccountDependent"><h6><input type=checkbox  class="paycheck" name="paycheck<%=counter%>"></h6></td>
        <td><input type="hidden" name="invoiceid<%=counter%>" id="invoiceid<%=counter%>" value=<%=rs.getString(4) %> >
        <input type="hidden" name="invoiceNumber<%=counter%>" id="invoiceNumber<%=counter%>" value=<%=rs.getString(1) %> ></td>
        <td><input type="hidden" name="clientid<%=counter%>" id="clientid<%=counter%>" value=<%=rs.getString(5) %> >
        <input type="hidden" name="amount<%=counter%>" id="amount<%=counter%>" value=<%=rs.getString(3) %> >
        
        </td>

        </tr>
          <tr><td style="height:4px"></td></tr>
        <% counter=counter+1;
    }
    }

    if (counter1==0)
    {%> 
    
    <tr class="secondarycurrency"><td colspan=5 >     
              <span class="AlertRed">Nous n'avons trouv&#233; aucune facture en devise am&#233;ricaine  <%=companyDOther %> currency.
              </span></td></tr>
       
    <%} %>
       </div> 
    <input type=hidden id="counter" name="counter" value="<%=counter%>"> 
    <% 
} catch (SQLException e) {
    System.err.println("SQLException: " + e.getMessage());
}
catch (Exception e) {
    System.err.println("SQLException: " + e.getMessage());
}
finally {
    if (cs != null) {
        try {
            cs.close();
        } catch (SQLException e) {
            System.err.println("SQLException: " + e.getMessage());
        }
    }
    if (con != null) {
        try {
            con.close();
        } catch (SQLException e) {
            System.err.println("SQLException: " + e.getMessage());
        }
    }
}


%>



 
     </table>
</body>
</html>

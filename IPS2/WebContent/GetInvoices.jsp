    <%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.io.*" %>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@page import="com.ips.database.*"%>
<%@ page import="com.ips.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
     <table border=0 cellpadding=0 cellspacing=0>
     <tr><td style="height:60px"></td></tr>
     

 
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

try {

	con = SqlServerDBService.getInstance().openConnection();
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
  
    
    Map<String,Invoice> invoices = FactorDBService.getInstance().getInvoices(payerid);
    //cs.setString(2, company);
    //cs.registerOutParameter(2, Types.VARCHAR);
    //cs.execute();
    //String str = cs.getString(1);
    int counter1=0;
    
       int loop =0;
       int loop1=0;
        int counter=0;
        
     
        for (String sysid: invoices.keySet()) 
        { if (loop==0){%></code>
               <tr><td colspan=2 ><h3>     
                <Label id="CurrencyInvoice" style="text-decoration:underline;color:#d06200"><%=companyD%> Invoices</Label>
                </h3></td></tr>
               <tr>
               <td style="width:250px"><h6>Supplier</h6></td>
                <td style="width:150px"><h6>PO Number</h6></td>
               <td style="width:150px"><h6>Invoice Number</h6></td>
               <td style="width:150px"><h6>Days Open</h6></td>
               <td style="width:100px"><h6>Status</h6></td>
               <td style="width:150px"><h6>Amount</h6></td>
               <td style="width:150px" class="AccountDependent AccountNoSelect"><div class="AccountNoSelect"><h6>Payment Amount</h6></div></td>
               <td style="width:150px" class="AccountDependent AccountNoSelect"><h6>Comments</h6></td>
               <td style="width:150px" class="AccountDependent AccountNoSelect"><h6>Confirm</h6></td>

              </tr>
   <code>      <%}
        loop=loop+1; 
        Invoice i = invoices.get(sysid);
        String invcurrency = i.getCompanyId();
        if (invcurrency !=null)
        	invcurrency = invcurrency.trim();
        if ((invcurrency.equals("01") && company.equals("01"))
        		||(!invcurrency.equals("01") && !company.equals("01")))
        {counter1=counter1+1;
        %></code>
     <tr>   
            <td><h6 style="font-size:1.7em;"><%=  i.getClientName() %></h6></td>
       <td><h6><%= i.getPoNumber() %></h6></td>
        <td><h6><%= i.getInvoiceId() %></h6></td>
        <td><h6><%   Date currentDate = new Date();
                  Date openDate = i.getPurchaseDate();
                  long daysms =  Math.abs(currentDate.getTime() - openDate.getTime());
                  long ONE_DAY = 1000 * 60 * 60 * 24;
                  int days = Math.round(daysms /ONE_DAY);
                  %>
        <%= days%></h6></td>
        <td><h6><%= colorMe(i.getStatus())%></h6></td>
        <td class="h6right"><% //DecimalFormat decim = new DecimalFormat("0.00");
        //String price2 = decim.format(Double.parseDouble(rs.getString(3)));
        NumberFormat fmt = NumberFormat.getCurrencyInstance(Locale.US);
        Double d = Double.parseDouble(i.getAssignment()) ;
		   String price2 = fmt.format(d);
      
        %><%=price2 %></h6></td>
     <!--   <td><h6>$<label id="discount" ></label></h6></td>-->  
        <td class="AccountDependent AccountNoSelect"><h6>$<input type=text style="width:80px" class="pay rightJustified" name="paymentamount<%=counter%>"></h6></td>
        <td class="AccountDependent AccountNoSelect"><h6><input type=text style="width:120px"  name="paymentComment<%=counter%>"></h6></td>
        
        <td class="AccountDependent AccountNoSelect"><h6><input type=checkbox  class="paycheck" name="paycheck<%=counter%>"></h6></td>
        <td><input type="hidden" name="invoiceid<%=counter%>" id="invoiceid<%=counter%>" value=<%=sysid %> >
        <input type="hidden" name="invoiceNumber<%=counter%>" id="invoiceNumber<%=counter%>" value=<%=i.getInvoiceId() %> ></td>
        <td><input type="hidden" name="clientid<%=counter%>" id="clientid<%=counter%>" value=<%=i.getClientSysId() %> >
        <input type="hidden" name="amount<%=counter%>" id="amount<%=counter%>" value=<%=i.getAssignment() %> >
        
        </td>

        </tr>
        <tr><td style="height:4px"></td></tr>
     <code>  <%} counter=counter+1;
        }  if(counter1==0)
    {%> 
    
    <tr><td colspan=5 >     
              <span class="AlertRed">We didn’t find any invoices in <%=companyD%> currency.
              </span></td></tr>
       
    <%} %>
        
         
   </div>
   <div id="secondarycurrency" style="visibility:hidden;width:1000px;">
    <!-- second round -->
    <% counter1=0;
 
    for (String sysid: invoices.keySet()){
    	
    	Invoice inv = invoices.get(sysid);
    	String invcurrency = inv.getCompanyId();
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
            <td><h6 style="font-size:1.7em;"><%= inv.getClientName() %></h6></td>
        <td><h6><%= inv.getPoNumber() %></h6></td>
        <td><h6><%= inv.getInvoiceId() %></h6></td>
        <td><h6><%   Date currentDate = new Date();
                  Date openDate = inv.getPurchaseDate();
                  long daysms =  Math.abs(currentDate.getTime() - openDate.getTime());
                  long ONE_DAY = 1000 * 60 * 60 * 24;
                  int days = Math.round(daysms /ONE_DAY);
                  %>
        <%= days%></h6></td>
      <td>  <h6><%= colorMe(inv.getStatus())%></h6></td>
        <td class="h6right">$<% DecimalFormat decim = new DecimalFormat("0.00");
        String price2 = String.format("%,14.2f",Double.parseDouble(inv.getAssignment()));

        %><%=price2 %></td>
      
     <!--   <td><h6>$<label id="discount" ></label></h6></td>-->  
        <td class="AccountDependent"><h6>$<input type=text style="width:80px" class="pay rightJustified" name="paymentamount<%=counter%>"></h6></td>
        <td class="AccountDependent"><h6><input type=text style="width:120px"  name="paymentComment<%=counter%>"></h6></td>
        
        <td class="AccountDependent"><h6><input type=checkbox  class="paycheck" name="paycheck<%=counter%>"></h6></td>
        <td><input type="hidden" name="invoiceid<%=counter%>" id="invoiceid<%=counter%>" value=<%=sysid %> >
        <input type="hidden" name="invoiceNumber<%=counter%>" id="invoiceNumber<%=counter%>" value=<%=inv.getInvoiceId() %> ></td>
        <td><input type="hidden" name="clientid<%=counter%>" id="clientid<%=counter%>" value=<%=inv.getClientSysId() %> >
        <input type="hidden" name="amount<%=counter%>" id="amount<%=counter%>" value=<%=inv.getAssignment() %> >
        
        </td>

        </tr>
          <tr><td style="height:4px"></td></tr>
        <% counter=counter+1;
    }
    }

    if (counter1==0)
    {%> 
    
    <tr class="secondarycurrency"><td colspan=5 >     
              <span class="AlertRed">We didn’t find any invoices in <%=companyDOther %> currency.
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

    SqlServerDBService.getInstance().releaseConnection(con);
}


%>



 
     </table>
</body>
</html>

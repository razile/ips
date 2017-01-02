<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language ="java" %>
<%@ page import="java.sql.*" %>
<%@ page buffer="16kb"%>

<HTML>
<head>
	<TITLE>IPS INVOICE PAYMENT SYSTEM</TITLE>		
<script type="text/css">
.table_border {
     border-style:solid;
     border-width:5px 5px 5px 5px;
     border-color:#d06200;
}
</script>
	<script id="clientEventHandlersJS" language="javascript">
		function CloseWindow()
			if ((userBrowser.browser == "Explorer" && (userBrowser.version == "9" || userBrowser.version == "8" || userBrowser.version == "7"))) {
        window.open('', '_self', '');
        window.close();
    } else if ((userBrowser.browser == "Explorer" && userBrowser.version == "6")) {
        window.opener = null;
        window.close();
    } else {
        window.opener = '';
        window.close(); // attempt to close window first, show user warning message if fails
        alert("To avoid data corruption/loss. Please close this window immedietly.");
    }
		</script> 
	<script type="text/javascript">
function noBack(){window.history.forward();}
</script>
</head>	
	
	<body onload="noBack();" onpageshow="if(event.persisted)noBack();" onbeforeunload="location.href='<% response.encodeURL("Logout.jsp"); %>'">
	

		<DIV style="WIDTH: 70px; DISPLAY: inline; HEIGHT: 15px" ms_positioning="FlowLayout"></DIV>
	<!--	<DIV style="Z-INDEX: 0; FONT-STYLE: italic; WIDTH: 612px; DISPLAY: inline; HEIGHT: 28px; COLOR: navy; FONT-SIZE: large; FONT-WEIGHT: bold"
			id="DIV1" language="javascript" onclick="return DIV1_onclick()" ms_positioning="FlowLayout"
			align="right">Thank you for using our services.</DIV>      -->
 <%    
    //session.removeAttribute("id");
	//session.removeAttribute("nm");
	//session.removeAttribute("cmp");
	session.invalidate();
	
	response.setHeader("Pragma","no-cache");   
	response.setHeader("Cache-Control","no-store");   
	response.setHeader("Expires","0");   
	response.setDateHeader("max-age",0);   
	response.setDateHeader("Expires",0);   
	
	response.sendRedirect("http://invoicepayment.ca");  %>
	
	<div STYLE="position:absolute;top:390px;left:300px;z-index:1;">
	<table border="0" width="750" class="table_border" cellspacing="0" cellpadding="0"><tr><td>
	<table border="0" width="750" cellspacing="0" cellpadding="0"><tr><td>
	<tr><td> <font face="arial" size="3">An error occurred while processing your request. Your session is expired. Please Click <a href="http://invoicepayment.ca">here</a> to log back in.</font> </td></tr>
	</table></td></tr></table>
	</div>
			
	</body>
</HTML>

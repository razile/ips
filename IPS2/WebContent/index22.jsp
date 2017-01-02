<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML> 
 
 
 <HEAD>
 
<LINK REL="shortcut icon" href="http://sbvps76.systembind.com/IPSmain/favicon.ico" type="image/x-icon"/> 

<title> Payer Login </title>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript"  src='http://cdn.renderedfont.com/js/renderedfont-0.8.min.js#free'></script>

<script type="text/javascript">
	var _gaq = _gaq || [];
	_gaq.push(['_setAccount', 'UA-33522368-1']);
	_gaq.push(['_trackPageview']);

	(function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	})();
	</script>
<style type="text/css">
      /* Example CSS class using Quicksand Book Regular */
      b.ips {
        font-family: "Quicksand Bold Regular", Arial; 
        font-size: 9pt; 
        color: #FFFFFF;
      }
    </style>
<script language="javascript">AC_FL_RunContent = 0;</script>
<script src="AC_RunActiveContent.js" language="javascript"></script>

<script type="text/javascript" language="javascript">
function trial()
{
    document.getElementById("txtTempBox").style.display="none";
    document.getElementById("txtPassword").style.display="";
    document.getElementById("txtPassword").focus();
}
</script>


<style type="text/css">
.tt {font-family: arial; font-size: 8pt;}
.ttt {color: #A0A0A0;}
 .thick {border-width: thin }
 .groove {border-style: groove }
 .outset {border-style: outset }
 .text-color { color: #0A70AB; }
 .special    { color: #AB830A; }
 
	a:link { 
	font-size: 8px;
	text-decoration: underline;
	}

	a:visited { 
	font-size: 8px;
	text-decoration: underline;
	}

	a:hover{
	background-color:#d06200;
	}

	.box { 
	background-color: #D6AC55; 
	border: 0px solid black; 
	height: 50px; 
	width: 232px; 
	padding: 1px; 
	spacing:1px;
	display:none; 
	position:absolute; 
	} 	
 </style> 
 
  <script type="text/javascript" language="JavaScript"> 
 <!--
	var cX = 0; var cY = 0; var rX = 0; var rY = 0; 
	function UpdateCursorPosition(e){ cX = e.pageX; cY = e.pageY;} 
	function UpdateCursorPositionDocAll(e){ cX = event.clientX; cY = event.clientY;} 
	if(document.all) { document.onmousemove = UpdateCursorPositionDocAll; } 
	else { document.onmousemove = UpdateCursorPosition; } 
	function AssignPosition(d) { 
	if(self.pageYOffset) { 
	rX = self.pageXOffset; 
	rY = self.pageYOffset; 
	} 
	else if(document.documentElement && document.documentElement.scrollTop) { 
	rX = document.documentElement.scrollLeft; 
	rY = document.documentElement.scrollTop; 
	} 
	else if(document.body) { 
	rX = document.body.scrollLeft; 
	rY = document.body.scrollTop; 
	} 
	if(document.all) { 
	cX += rX; 
	cY += rY; 
	} 
		 d.style.left = (920) + "px"; 
	     d.style.top = (350) + "px";  
	} 
	function HideText(d) { 
	if(d.length < 1) { return; } 
	document.getElementById(d).style.display = "none"; 
	} 
	function ShowText(d) { 
	if(d.length < 1) { return; } 
	var dd = document.getElementById(d); 
	AssignPosition(dd); 
	dd.style.display = "block"; 
	} 
	function ReverseContentDisplay(d) { 
	if(d.length < 1) { return; } 
	var dd = document.getElementById(d); 
	AssignPosition(dd); 
	if(dd.style.display == "none") { dd.style.display = "block"; } 
	else { dd.style.display = "none"; } 
	} 

	top.window.moveTo(0,0);
	if (document.all) {
	top.window.resizeTo(screen.availWidth,screen.availHeight);
	}
	else if (document.layers||document.getElementById) {
	if (top.window.outerHeight<screen.availHeight||top.window.outerWidth<screen.availWidth){
	top.window.outerHeight = screen.availHeight;
	top.window.outerWidth = screen.availWidth;
	}
	}
	//-->
	</script> 
<script type="text/javascript">
	function getTextValue1()
	{
		var y =document.getElementById("t1");
		y.value="";
	}
</script>
	
<script type="text/javascript">
function noBack(){window.history.forward();}
</script>
 
 
 </HEAD> 
 <BODY>
 
 
 
  
 <%@ page import="java.sql.*" %> 



<script language="JavaScript">
var nHist = window.history.length;
if(window.history[nHist] != window.location)
  window.history.forward();
</script>

	<table border="0"  cellspacing="0" cellpadding="0" width="1200" align="left" style='table-layout:fixed'>
	<tr><td align="left"> <img src="ipsban.jpg" width="100%"></td></tr></table>
	
	<div STYLE="position:absolute;top:90px;left:50px;z-index:2">
	<table border="0" width="1150" style='table-layout:fixed'; >
	 <tr>
	 <td colspan="1"> <b class="ips renderedFont">Welcome to IPS Invoice Payment System Corp.</b></td><td width="220"> &nbsp;</td>
	 <td colspan="1"> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; 
	      <a href="feedbk.jsp" style="color:#FFFFFF" target="_blank"> <b class="ips renderedFont">Feedback</b></a> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; 
	      <a href="/en/contact_ips_invoice_payment_systems.html" style="color:#FFFFFF" target="_blank"> <b class="ips renderedFont">Contact Us</b></a> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; 
		  <a href="/index.jsp" style="color:#FFFFFF" target="_top"> <b class="ips renderedFont">IPS Home</b></a> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; 
		  <a href="Payer_Manual.pdf" style="color:#FFFFFF" target="_blank"> <b class="ips renderedFont">Help</b></a> </td>
	 </tr></table>
	</div>
	
	<!--	
	<div STYLE="position:absolute;z-index:2; top:250px;left:10px;z-index:1"> 
		<table border="0" width="1200" align="center" style='table-layout:fixed'><tr><td width="20"> &nbsp;</td><td align="center">
			<OBJECT style="Z-INDEX: 115; border:0px solid rgb(105, 105, 105); POSITION: relative; TOP: 1px;"
				id="invoice" codeBase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
				classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="420" align="middle" height="222">
				<param name="height" value="222" />
				<param name="width" value="420" />
				<PARAM NAME="_cx" VALUE="6138">
				<PARAM NAME="_cy" VALUE="6138">
				<PARAM NAME="FlashVars" VALUE="">
				<PARAM NAME="Movie" VALUE="invoice2.swf">
				<PARAM NAME="Src" VALUE="invoice2.swf">
				<PARAM NAME="WMode" VALUE="Window">
				<PARAM NAME="Play" VALUE="-1">
				<PARAM NAME="Loop" VALUE="-1">
				<PARAM NAME="Quality" VALUE="High">
				<PARAM NAME="SAlign" VALUE="">
				<PARAM NAME="Menu" VALUE="-1">
				<PARAM NAME="Base" VALUE="">
				<PARAM NAME="AllowScriptAccess" VALUE="sameDomain">
				<PARAM NAME="Scale" VALUE="ShowAll">
				<PARAM NAME="DeviceFont" VALUE="0">
				<PARAM NAME="EmbedMovie" VALUE="0">
				<PARAM NAME="BGColor" VALUE="">
				<PARAM NAME="SWRemote" VALUE="">
				<PARAM NAME="MovieData" VALUE="">
				<PARAM NAME="SeamlessTabbing" VALUE="1">
				<PARAM NAME="Profile" VALUE="0">
				<PARAM NAME="ProfileAddress" VALUE="">
				<PARAM NAME="ProfilePort" VALUE="0">
				<PARAM NAME="AllowNetworking" VALUE="all">
				<PARAM NAME="AllowFullScreen" VALUE="false">
				<embed src="invoice2.swf" quality="high" bgcolor="#ffffff"  name="invoice2"
					align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash"
					pluginspage="http://www.macromedia.com/go/getflashplayer" width="420" height="222"> 
			</OBJECT></td>					
			</tr></table> 
			</div> -->


	 <div STYLE="position:absolute;top:240px; left:400px;z-index:2"> 
		   <iframe height="235px" width="432px" frameborder="0" scrolling="no" src='btest.htm'></iframe> 
	</div>
	
	
	
	
 <TABLE BORDER=1 WIDTH="75%"> 
 <TR><TH>Last Name</TH><TH>First Name</TH></TR> 

 <% 
 java.sql.Connection conn = null; 
 java.sql.PreparedStatement  stmt = null; 
 ResultSet rs = null;  
        try{
        	String driver = "com.mysql.jdbc.Driver";
            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "password");
            stmt = conn.prepareStatement("SELECT * FROM tbluser");
            rs = stmt.executeQuery();
            while(rs.next()){
%>
<TR><TD><%=rs.getString("firstname") %></TD> 
 <TD><%=rs.getString("lastname") %></TD></TR> 

<% 
            }
        }        catch(Exception e){
            e.printStackTrace();
        }

  finally { 
 if (rs != null) rs.close(); 
 if (stmt != null) stmt.close(); 
 if (conn != null) conn.close(); 
 } 
 %> 
 </TABLE>
 
 
 
	<div STYLE="position:absolute;top:800px;left:10px;z-index:2"> <table border="0" width="1200" style='table-layout:fixed'><tr><td align="center" nowrap="nowrap"> <font face="arial" color="#FFFFF" size="2">©</font><b class="ips renderedFont"> 2013 IPS Invoice Payment System Corporation. All rights reserved.</b></td></tr></table></div>
	<div STYLE="position:absolute;top:770px;left:10px;z-index:1"> <table border="0" width="1200" style='table-layout:fixed'><tr><td align="center"><img src="footer.jpg" width="96%" height="60px"></td></tr></table></div> 
 
 </BODY> 
 </HTML> 
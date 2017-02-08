<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
 <script src="https://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
 <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Effectuer un paiement</title>

	<script>
	function getQueryStrings() { 
		  var assoc  = {};
		  var decode = function (s) { return decodeURIComponent(s.replace(/\+/g, " ")); };
		  var queryString = location.search.substring(1); 
		  var keyValues = queryString.split('&'); 

		  for(var i in keyValues) { 
		    var key = keyValues[i].split('=');
		    if (key.length > 1) {
		      assoc[decode(key[0])] = decode(key[1]);
		    }
		  } 

		  return assoc; 
		} 
	var qs = getQueryStrings();
	var id1 = qs["id"]; 

	$(document).ready(function() {
		$('input[id="hiddenId"]').val(id1);
		$("#form1").submit();
	});
	
</script>

</head>
<body>
<form method=post action="GeneratedInvoicef" id="form1">
<input type="hidden" id="hiddenId" name="hiddenId"/>
</form>
<div id="showtext"></div>

</body>
</html>
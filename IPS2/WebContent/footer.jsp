</td></tr>
</table>
</div>
<div id="footer1" STYLE="position:absolute;top:880px;left:10px;z-index:2"> <table border="0" width="1150" align="center" style='table-layout:fixed'><tr><td align="center" nowrap="nowrap">  <font face="arial" color="#FFFFF" size="2">©2014 IPS Invoice Payment System Corporation. All rights reserved.</font> </td></tr></table></div>
	<div  id="footer2" STYLE="position:absolute;top:850px;left:10px;z-index:1"> <table border="0" width="1150" align="center" style='table-layout:fixed'><tr><td align="center"><img src="footer.jpg" width="96%" height="60px"></td></tr></table></div> 

</body>
</html>

<script>
function updateFooter( w){
x = $('#innerbody').height()+20; // +20 gives space between div and footer
y = $(window).height();
//alert(x+ ' '+y);

if (x>500)
{ // 100 is the height of your footer
    $('#footer1').css('top', x+80+w+'px');// again 100 is the height of your footer
    $('#footer1').css('display', 'block');
    $('#footer2').css('top', x+50+w+'px');// again 100 is the height of your footer
    $('#footer2').css('display', 'block');
}
}
</script>
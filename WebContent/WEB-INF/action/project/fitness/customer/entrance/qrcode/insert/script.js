<rows>
if( "1" == "${fld:resultcode}" ){
	$("#msg").html("入场刷卡成功");
}else{
	$("#msg").html("${fld:resultmsg@js}");
}
$("#qrcode").val("");
</rows>
$("#qrcode").focus();
<rows>
if( "1" == "${fld:resultcode}" ){
	$("#result").html("入场刷卡成功！");
	window.clearInterval(qritv);
}else if( "2" == "${fld:resultcode}" ){
	$("#result").html("${fld:resultmsg}！");
}
</rows>

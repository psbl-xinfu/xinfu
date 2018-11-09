<rows>
if( "1" == "${fld:resultcode}" ){
	$("#result").html("签课成功");
	// 跳转至评价界面
	location.href = contextPath+"/action/project/fitness/wx/cust/center/evaluate?ptrestcode=${fld:ptrestcode}";
}else{
	$("#result").html("${fld:resultmsg@js}");
}
</rows>
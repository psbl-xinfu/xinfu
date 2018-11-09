
if(parseInt("${fld:num}")>0){
	$("#cardcode").val("");
	ccms.dialog.notice("该卡号已存在！", 5000);
}

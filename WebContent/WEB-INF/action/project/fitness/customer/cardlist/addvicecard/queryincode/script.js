
if(parseInt("${fld:num}")>0){
	$("#incode").val("");
	ccms.dialog.notice("该卡内码已存在！", 5000);
}

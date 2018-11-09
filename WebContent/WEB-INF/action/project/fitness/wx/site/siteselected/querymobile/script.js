
if(parseInt("${fld:num}")>0){
	$("#mobile").val("");
	ccms.dialog.notice("该手机号码已存在！", 3000);
}

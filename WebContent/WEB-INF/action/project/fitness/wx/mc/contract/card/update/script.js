$("#contractcode").val("${fld:contractcode}");
if( istopay ){
	topay("${fld:contractcode}");
}else{
	ccms.dialog.notice("保存成功", 2000);
}

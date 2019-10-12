$("#contractcode").val("${fld:contractcode}");
if( istopay ){
	topay("${fld:contractcode}");
}else{
	parent.search.searchData(1);
	ccms.dialog.notice("保存成功", 2000);
}

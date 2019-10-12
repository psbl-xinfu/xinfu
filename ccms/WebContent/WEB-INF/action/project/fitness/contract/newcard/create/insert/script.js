$("#contractcode").val("${fld:newcontractcode}");
if( istopay ){
	topay("${fld:newcontractcode}");
}else{
	parent.search.searchData(1);
	ccms.dialog.notice("保存成功", 2000);
}

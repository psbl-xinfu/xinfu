ccms.dialog.notice("保存成功！",2000,function(){
	$("#fillcard_code").val("${fld:vc_code}");
	search.searchData(1);
});
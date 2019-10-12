ccms.dialog.notice("添加成功！",2000,function(){
	$("#traincode").val("${fld:code}");
	parent.search.searchData(1);
});
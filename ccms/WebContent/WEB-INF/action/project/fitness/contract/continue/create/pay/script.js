$("#billcode").val("${fld:billcode}");
ccms.dialog.notice("收款成功", 2000, function(){
	parent.search.searchData(1);
	try{
		ccms.dialog.close();
	}catch(e){}
});

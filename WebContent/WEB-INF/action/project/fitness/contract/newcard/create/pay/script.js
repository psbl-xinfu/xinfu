$("#billcode").val("${fld:billcode}");
ccms.dialog.notice("收款成功", 2000, function(){
	try{
		parent.$('#search_btn').click();
		ccms.dialog.close();
	}catch(e){}
});

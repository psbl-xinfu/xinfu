ccms.dialog.notice("入场刷卡成功！",1000,function(){
	$("#searchhtml").hide();
	ccms.util.clearForm("searchForm");
	$("#custall").focus();
});
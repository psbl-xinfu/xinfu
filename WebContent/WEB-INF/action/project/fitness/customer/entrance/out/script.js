ccms.dialog.notice("退场刷卡成功！",1000,function(){
	$("#searchhtml").hide();
	ccms.util.clearForm("searchForm");
	getAjaxCall("${def:context}${def:actionroot}/querycatemp", false);
	$("#custall").focus();
	//查询入场记录
	$("#search_btn").click();
});
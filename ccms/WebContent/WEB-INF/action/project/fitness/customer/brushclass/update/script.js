ccms.dialog.notice("签课成功！",2000,function(){
	$("#ptlevelname,#staff_name,#ptfee,#ptenddate,#pttype,#status,#preparedate,#ptleftcount").html("");
	$("#searchhtml").hide();
	ccms.util.clearForm("searchForm");
	$("#custall").focus();
	//判断是否需要打印小票
	if("${fld:isprint}"=="1"){
		var uri="${def:context}/action/project/fitness/print/ticket/ptdetailprepareprint?pk_value=${fld:ptpcode}";
		ajaxCall(uri,{
			method: "get",
			progress: true,
			dataType: "script",
			success: function() {
			}
		});
	}
});
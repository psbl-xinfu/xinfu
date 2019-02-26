ccms.dialog.notice("入场刷卡成功！",1000,function(){
	$("#searchhtml").hide();
	if('${fld:nowcount}'!=""){
		if("${fld:isprintcount}"=="1"){
			var url = "${def:context}/action/project/fitness/print/ticket/wordtemplate_Admission_card?pk_value=${fld:cardcode}&nowcount=${fld:nowcount}&org_id=${fld:unionorgid}";
			ajaxCall(url,{
				method : "get",
				progress : true,
				dataType : "script",
				success : function() {
				}
			});
		}
	}
	ccms.util.clearForm("searchForm");
	$("#custall").focus();
	//查询入场记录
	$("#search_btn").click();
});
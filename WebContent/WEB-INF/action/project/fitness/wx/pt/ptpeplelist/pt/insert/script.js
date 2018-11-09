$("#contractcode").val("${fld:newcontractcode}");
ccms.dialog.notice("办理成功！",1000,function(){
	location.href="${def:context}/action/project/fitness/wx/pt/ptpeplelist/crud";
});
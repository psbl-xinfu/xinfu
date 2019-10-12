
if("${fld:status}"!="1"){
	ccms.dialog.notice("该客诉已处理！");
}else{
	var commurl = '${def:context}/action/project/fitness/customer/feedback/validation?';
		commurl+='name=${fld:name@js}&mobile=${fld:mobile}';
		commurl+='&feedbackid=${fld:tuid}&customercode=${fld:customercode}';
	ajaxCall(commurl,{
	   	method: "get",
	   	progress: true,
	   	dataType: "script",
	   	success: function() {
		}
	});
}

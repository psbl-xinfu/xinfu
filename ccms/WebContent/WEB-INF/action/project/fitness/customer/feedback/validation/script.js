if("${fld:status}"!="1"){
	ccms.dialog.notice("该客诉已处理！");
}else{
	if("${fld:followstaff}"=="${def:user}"){
		var commurl = '${def:context}${def:actionroot}/custcomm?'
			+'name=${fld:name}&mobile=${fld:mobile}&feedbackid=${fld:feedbackid}&customercode=${fld:customercode}';
		top.ccms.dialog.open({url : commurl, width:'1170',height:'600'});
	}else{
		ccms.dialog.notice("该客诉处理人为${fld:staffname}，您不能处理！");
	}
}
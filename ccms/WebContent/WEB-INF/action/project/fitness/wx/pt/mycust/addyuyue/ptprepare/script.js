﻿if("${fld:dat}"==1){
	ccms.dialog.notice("该门店正在放假中，不能预约！",2000)
}else if("${fld:work}"==1){
	ccms.dialog.notice("该预约不在门店上班时间内或超过门店上班时间，不能再次预约！",2000)
}else if("${fld:ptstatus}"==1){
	ccms.dialog.notice("该课程已过期，不能预约！",2000)
}else if("${fld:num}"==1){
	ccms.dialog.notice("该课程剩余课时不足，不能预约！",2000)
}else if("${fld:timet}"==1){
	ccms.dialog.notice("预约日期必须大于等于当前日期，预约时间必须当天内！",2000)
}else if("${fld:workdate}"==1){
	ccms.dialog.notice("该时间段已预约或上课中，不能再次预约！",2000)
}else if("${fld:ptprepare}"==1){
	ccms.dialog.notice("该课程没有分配教练不能预约！",2000)
}else{
	var preparedate="${fld:preparedate}";
	var preparetime="${fld:preparetime}";
	var customercode="${fld:customercode}";
	var ptrestcode="${fld:ptrestcode}";
    var url="${def:context}${def:actionroot}/insert?preparedate="+preparedate+"&preparetime="+preparetime+"&customercode="+customercode+"&ptrestcode="+ptrestcode;
	ajaxCall(url,{
		method: "post",
		progress:false,
		dataType: "script",
		success: function() {
			ccms.dialog.notice("预约成功！",2000);
		}
    });
	
}




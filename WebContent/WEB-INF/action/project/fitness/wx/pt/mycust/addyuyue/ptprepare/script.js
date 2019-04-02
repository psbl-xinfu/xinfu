if("${fld:dat}"==1){
	ccms.dialog.notice("该门店正在放假中，不能预约！",2000)
	return false;
}
 if("${fld:work}"==1){
	ccms.dialog.notice("该预约不在门店上班时间内或超过门店上班时间，不能再次预约！",2000)
	return false;
}
 if("${fld:ptstatus}"==1){
	ccms.dialog.notice("该课程已过期，不能预约！",2000)
	return false;
}
 if("${fld:num}"==1){
	ccms.dialog.notice("该课程剩余课时不足，不能预约！",2000)
	return false;
}if("${fld:time}"==1){
	ccms.dialog.notice("预约日期必须大于等于当前日期，预约时间必须当天内！",2000)
	return false;
}
 if("${fld:workdate}"==1){
	ccms.dialog.notice("该时间段已预约或上课中，不能再次预约！",2000)
	return false;
}
if("${fld:ptprepare}"==1){
	ccms.dialog.notice("该课程没有分配教练不能预约！",2000)
	return false;
}else{
	ccms.dialog.notice("预约成功！",1000,function(){
		location.href="${def:context}/action/project/fitness/wx/pt/mycust/sijiaohuiyuanmsg?customercode="+$('#customercode').val()+"&type=pt";
	});
}







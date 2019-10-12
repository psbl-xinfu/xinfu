
if("${fld:votetype}"==0){
	$("input[name=votetype]:eq(0)").iCheck('check');
}else{
	$("input[name=votetype]:eq(1)").iCheck('check');
}

if("${fld:totalnum}"==""||"${fld:totalnum}"==null){
	$("input[name=totalnumRadio]:eq(0)").iCheck('check');
}else{
	$("input[name=totalnumRadio]:eq(1)").iCheck('check');
	document.messageForm.totalnum.value = "${fld:totalnum}";
}

if("${fld:logoid}"==""||"${fld:logoid}"==null){
	$("input[name=logoidRadio]:eq(0)").iCheck('check');
	$('.upload-img').attr("src","${def:context}/js/project/fitness/image/btn-default-upload-img.png");
}else{
	$("input[name=logoidRadio]:eq(1)").iCheck('check');
	uploadOk("${fld:logoid}");
}
document.messageForm.logoid.value = "${fld:logoid}";

document.messageForm.tuid.value = "${fld:code}";
document.messageForm.startdate.value = "${fld:startdate}";
document.messageForm.enddate.value = "${fld:enddate}";
document.messageForm.votenum.value = "${fld:votenum}";
document.messageForm.campaignrules.value = "${fld:campaignrules}";
document.messageForm.campaign_name.value = "${fld:campaign_name}";
document.messageForm.remark.value = "${fld:remark}";


document.messageForm.enrollfdate.value = "${fld:enrollfdate}";
document.messageForm.enrolltdate.value = "${fld:enrolltdate}";
document.messageForm.voteremark.value = "${fld:voteremark}@js";



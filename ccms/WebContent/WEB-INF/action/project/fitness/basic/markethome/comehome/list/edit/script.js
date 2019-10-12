document.messageForm.c_code.value = "${fld:code}";
document.messageForm.c_campaign_name.value = "${fld:campaign_name}";
document.messageForm.c_expercardcode.value = "${fld:expercardcode}";

if("${fld:totalnum}"==''){
	$("input[name=totalnum]:eq(0)").iCheck('check');
}else{
	$("input[name=totalnum]:eq(1)").iCheck('check');
	document.messageForm.c_totalnum.value = "${fld:totalnum}";
}

if("${fld:personnum}"==''){
	$("input[name=personnum]:eq(0)").iCheck('check');
}else{
	$("input[name=personnum]:eq(1)").iCheck('check');
	document.messageForm.c_personnum.value = "${fld:personnum}";
}

if("${fld:validatetype}"==0){
	$("input[name=c_validatetype]:eq(0)").iCheck('check');
}else{
	$("input[name=c_validatetype]:eq(1)").iCheck('check');
}

if("${fld:rankrules}"==0){
	$("input[name=c_rankrules]:eq(0)").iCheck('check');
}else{
	$("input[name=c_rankrules]:eq(1)").iCheck('check');
}

document.messageForm.c_startdate.value = "${fld:startdate}";
document.messageForm.c_enddate.value = "${fld:enddate}";
document.messageForm.c_link.value = "${fld:link}";
document.messageForm.c_campaignrules.value = "${fld:campaignrules}";
document.messageForm.c_status.value = "${fld:status}";

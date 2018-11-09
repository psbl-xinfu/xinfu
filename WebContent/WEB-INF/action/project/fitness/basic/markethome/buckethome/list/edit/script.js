document.messageForm.c_code.value = "${fld:code}";
document.messageForm.c_campaign_name.value = "${fld:campaign_name}";

if("${fld:validatetype}"==0){
	$("input[name=c_validatetype]:eq(0)").iCheck('check');
}else{
	$("input[name=c_validatetype]:eq(1)").iCheck('check');
}

document.messageForm.c_status.value = "${fld:status}";
$("#c_status").selectpicker("refresh");
$("#c_status").selectpicker("render");

document.messageForm.c_startdate.value = "${fld:startdate}";
document.messageForm.c_enddate.value = "${fld:enddate}";
document.messageForm.c_link.value = "${fld:link}";
document.messageForm.c_campaignrules.value = "${fld:campaignrules}";


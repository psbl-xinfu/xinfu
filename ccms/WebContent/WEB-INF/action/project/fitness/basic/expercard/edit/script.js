document.messageForm.c_code.value = "${fld:code}";
document.messageForm.c_cardname.value = "${fld:name@js}";
document.messageForm.c_experlimit.value = "${fld:experlimit}";

document.messageForm.c_name.value = "${fld:org_name}";
document.messageForm.c_contact_phone.value = "${fld:contact_phone}";
document.messageForm.c_address.value = "${fld:address}";



$('#see_org_name').text("${fld:org_name}");
$('#see_contact_phone').text( "${fld:contact_phone}");
$('#see_address').text("${fld:address}");

if("${fld:expertype}"==0){
	$("input[name=c_expertype]:eq(0)").iCheck('check');
}else if("${fld:expertype}"==1){
	$("input[name=c_expertype]:eq(1)").iCheck('check');
}else{
	$("input[name=c_expertype]:eq(2)").iCheck('check');
}

if("${fld:validatetype}"==0){
	$("input[name=c_validatetype]:eq(0)").iCheck('check');
}else if("${fld:validatetype}"==1){
	$("input[name=c_validatetype]:eq(1)").iCheck('check');
}else{
	$("input[name=c_validatetype]:eq(2)").iCheck('check');
	$('#c_enddate').val("${fld:enddate}");
	$('#c_startdate').val("${fld:startdate}");
	$('#l_date').text("${fld:startdate}至${fld:enddate}");
}
document.messageForm.c_useremark.value = "${fld:useremark@js}";
setSelectValue($('#c_status'),"${fld:status}");

$('#l_phone').text("${fld:contact_phone@js}");
$('#l_descr').text("${fld:descr@js}");
$('#l_usedescr').text("${fld:useremark@js}");
$('#l_cardname').text("${fld:name@js}");

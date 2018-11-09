document.messageForm.c_code.value = "${fld:code}";
document.messageForm.c_cardname.value = "${fld:name}";
if("${fld:covertype}"==0){
	$("input[name=c_covertype]:eq(0)").iCheck('check');
	document.messageForm.color.value = "${fld:covervalue}";
	$('#color').blur();
}else{
	$("input[name=c_covertype]:eq(1)").iCheck('check');
	document.messageForm.c_img.value = "${fld:covervalue}";
	uploadOk("${fld:covervalue}");
}
document.messageForm.c_descr.value = "${fld:descr}";
document.messageForm.c_contact_phone.value = "${fld:contact_phone}";
document.messageForm.c_address.value = "${fld:address}";

if("${fld:expertype}"==0){
	$("input[name=c_expertype]:eq(0)").iCheck('check');
}else if("${fld:expertype}"==1){
	$("input[name=c_expertype]:eq(1)").iCheck('check');
}else{
	$("input[name=c_expertype]:eq(2)").iCheck('check');
}
document.messageForm.c_experlimit.value = "${fld:experlimit}";

if("${fld:validatetype}"==0){
	$("input[name=c_validatetype]:eq(0)").iCheck('check');
}else if("${fld:expertype}"==1){
	$("input[name=c_validatetype]:eq(1)").iCheck('check');
}else{
	$("input[name=c_validatetype]:eq(2)").iCheck('check');
	$('#c_enddate').val("${fld:enddate}");
	$('#c_startdate').val("${fld:startdate}");
	$('#l_date').text("${fld:startdate}至${fld:enddate}");
}
document.messageForm.c_isneddmobile.value = "${fld:isneddmobile}";
document.messageForm.c_useremark.value = "${fld:useremark}";
document.messageForm.c_status.value = "${fld:status}";

$('#l_phone').text("${fld:contact_phone}");
$('#l_addr').text("${fld:address}");
$('#l_cardname').text("${fld:name}");
$('#l_descr').text("${fld:descr}");
$('#l_usedescr').text("${fld:useremark}");

document.addForm.cc_thecode.value="${fld:ttcode}";
document.addForm.cc_guestcode.value="${fld:guestcode}";
document.addForm.cc_name.value="${fld:ttname}";
document.addForm.cc_mobile.value="${fld:vc_mobile}";
document.addForm.cc_birth.value="${fld:birthday}";
document.addForm.remark.value="${fld:remark}";

document.addForm.cc_mobile2.value="${fld:mobile2}";
document.addForm.cc_email.value="${fld:email}";
document.addForm.cc_trill.value="${fld:trill}";
document.addForm.cc_wechat.value="${fld:wechat}";
setSelectValue($("#cc_sex"), "${fld:i_sex}");
setSelectValue($("#cc_position"), "${fld:poscode}");

setSelectValue($("#cc_branchcode"), "${fld:branchcode}");


var possibilitybin='${fld:possibility}';
var possibilityarr=possibilitybin.split(",");

$('#cc_possibility').selectpicker('val', possibilityarr);

var thecoursebin='${fld:thecourse}';
var thecoursearr=thecoursebin.split(",");

$('#cc_thecourse').selectpicker('val', thecoursearr);



 



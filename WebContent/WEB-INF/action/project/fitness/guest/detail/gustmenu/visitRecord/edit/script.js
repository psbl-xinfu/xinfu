document.addForm.cc_code.value="${fld:ttcode}";
document.addForm.cc_name.value="${fld:ttname}";
document.addForm.cc_mobile.value="${fld:vc_mobile}";
document.addForm.cc_birth.value="${fld:birthday}";
document.addForm.remark.value="${fld:remark}";
setSelectValue($("#cc_sex"), "${fld:i_sex}");
setSelectValue($("#cc_position"), "${fld:poscode}");
/*
//修改id号  zyb 2019-3-21
$("#ttname").selectpicker("refresh");
$("#ttname").selectpicker("render");*/

 



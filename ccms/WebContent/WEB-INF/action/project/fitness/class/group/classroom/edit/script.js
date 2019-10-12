document.formEditor.vc_code.value = "${fld:code@js}";
document.formEditor.name.value = "${fld:classroom_name@js}";
document.formEditor.f_area.value="${fld:area}";
document.formEditor.vc_type.value="${fld:room_type@js}";
document.formEditor.i_limit.value="${fld:limit_num}";
document.formEditor.vc_remark.value="${fld:remark@js}";
ccms.util.setCheckboxValue('status',"${fld:status}","formEditor");
ccms.util.setCheckboxValue('vc_ispreparedevice',"${fld:ispreparedevice}","formEditor");
"${fld:speciallimit}"==0?$("#i_limit_chk").iCheck("uncheck"):$("#i_limit_chk").iCheck("check");

document.formEditor.vc_code.value = "${fld:code@js}";
document.formEditor.vc_content.value = "${fld:rules_name@js}";
ccms.util.setCheckboxValue('i_isrules',"${fld:isrules}","formEditor");
document.formEditor.deduction.value="${fld:isrules}"==0?"${fld:fixed_value}":"${fld:percent_value}";
document.formEditor.vc_remark.value="${fld:remark@js}";
ccms.util.setCheckboxValue('i_status',"${fld:status}","formEditor");

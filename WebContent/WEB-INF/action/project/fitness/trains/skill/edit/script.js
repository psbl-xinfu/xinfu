//clearForm("formEditor");
document.formEditor.tuid.value = "${fld:tuid}";
setSelectValue($("#skill_id"), "${fld:skill_id}");
setSelectValue($("#course_id"), "${fld:courseid}");
document.formEditor.begin_date.value = "${fld:begin_date}";
document.formEditor.end_date.value = "${fld:end_date}";
document.formEditor.showorder.value = "${fld:showorder}";


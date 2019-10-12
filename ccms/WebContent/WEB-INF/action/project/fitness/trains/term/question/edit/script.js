//clearForm("formEditor");
document.formEditor.tuid.value = "${fld:tuid}";
document.formEditor.question_name.value = "${fld:question_name}";
document.formEditor.question_code.value = "${fld:question_code}";
document.formEditor.question_score.value = "${fld:question_score}";
setSelectValue($("#question_type"), "${fld:question_type}");
document.formEditor.showorder.value = "${fld:showorder}";


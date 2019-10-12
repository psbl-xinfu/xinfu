document.formEditor.tuid.value = "${fld:tuid}";
document.formEditor.course_name.value = "${fld:course_name@js}";
document.formEditor.course_desc.value = "${fld:course_desc@js}";

<coursegroup-row>
setSelectValue($("#grouptuid"), "${fld:groupid}");
</coursegroup-row>

document.formEditor.tuid.value = "${fld:tuid}";
document.formEditor.item_name.value = "${fld:item_name@js}";
document.formEditor.item_code.value = "${fld:item_code}";
document.formEditor.show_order.value = "${fld:show_order}";
document.formEditor.remark.value = "${fld:remark@js}";
document.formEditor.type_id.value = "${fld:type_id}";
document.formEditor.tags.value = "${fld:tags}";
setCheckboxValue("is_matrix","${fld:is_matrix}","formEditor");
setCheckboxValue("is_matrix_transpose","${fld:is_matrix_transpose}","formEditor");
setCheckboxValue("is_page_break","${fld:is_page_break}","formEditor");
setCheckboxValue("list_show_type","${fld:list_show_type}","formEditor");
setCheckboxValue("is_list_mline","${fld:is_list_mline}","formEditor");

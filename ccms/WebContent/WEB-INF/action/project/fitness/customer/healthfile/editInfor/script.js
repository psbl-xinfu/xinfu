<search-list>
document.formmEditor.vc_code.value = "${fld:code}";
document.formmEditor.i_status.value = "${fld:status}";
document.formmEditor.vc_name.value = "${fld:name}";
document.formmEditor.i_sex.value = "${fld:sex}";
document.formmEditor.vc_club.value = "${fld:org_id}";
ccms.util.setCheckboxValue('vc_club',"${fld:fullname}","formmEditor");
document.formmEditor.c_birthdate.value = "${fld:birthdate}";
</search-list>

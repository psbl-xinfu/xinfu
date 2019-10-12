document.formEditor.f_mealdiscount.value = "${fld:a}";
document.formEditor.f_drinkdiscount.value = "${fld:b}";
document.formEditor.f_jsdiscount.value = "${fld:c}";
document.formEditor.f_swimdiscount.value = "${fld:d}";
document.formEditor.f_singlediscount.value = "${fld:e}";
document.formEditor.f_classdiscount.value = "${fld:f}";

var tobj = $("#discount_datagrid");
tobj.empty();
var rowno = 0;
<disc-rows>
	rowno++;
	tobj.append('<tr><td align="center" nowrap>' + rowno + '</td>'
		+ '<td align="center" nowrap>${fld:vc_storage_name@js}</td>'
		+ '<td align="center"><input type="hidden" name="vc_storage" value="${fld:vc_storage}" size="8" />'
		+ '<input type="text" name="f_discount" value="${fld:f_discount}" size="8" /></td></tr>');
</disc-rows>

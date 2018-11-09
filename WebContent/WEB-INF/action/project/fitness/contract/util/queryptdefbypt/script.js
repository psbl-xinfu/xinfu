var selectobj = $("#${fld:objid}");
selectobj.empty();
selectobj.append('<option value="">请选择</option>');
<rows>
	selectobj.append('<option value="${fld:code}" code1="${fld:ptfee}" code2="${fld:scale}">${fld:ptlevelname@js}</option>');
</rows>
$("#ptlevelcode").selectpicker("refresh");
$("#ptlevelcode").selectpicker("render");
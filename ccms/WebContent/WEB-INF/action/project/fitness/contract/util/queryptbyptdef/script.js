var selectobj = $("#${fld:objid}");
selectobj.empty();
selectobj.append('<option value="">请选择</option>');
<rows>
	selectobj.append('<option value="${fld:userlogin}">${fld:name@js}</option>');
</rows>

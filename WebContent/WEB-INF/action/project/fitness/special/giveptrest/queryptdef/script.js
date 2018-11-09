
var str = "<option value=''>请选择</option>";
<ptdef-rows>
	str+="<option value='${fld:code}' code='${fld:ptfee}'>${fld:ptlevelname}</option>";
</ptdef-rows>
$("#defcode").html(str);
$("#defcode").selectpicker("refresh");
$("#defcode").selectpicker("render");

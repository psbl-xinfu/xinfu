
var val = "<option value=''>请选择</option>";
<rows>
	val+="<option value='${fld:code@js}'>${fld:name@js}</option>";
</rows>
$("#cardcode").html(val);

$("#cardcode").selectpicker("refresh");
$("#cardcode").selectpicker("render");
<custrows>
$("#customercode").val("${fld:cust_code@js}");
$("#cust_name").val("${fld:cust_name@js}");
$("#mobile").val("${fld:mobile@js}");
</custrows>

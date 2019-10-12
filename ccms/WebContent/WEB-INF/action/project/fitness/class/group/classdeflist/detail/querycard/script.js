
var val = "<option value=''>请选择</option>";
var num = 0;
<rows>
	if(num<1){
		$("#custcode").val("${fld:custcode}");
	}
	num++;
	val+="<option value='${fld:code}'>${fld:name}</option>";
</rows>
$("#cardcode").html(val);
$("#cardcode").selectpicker("refresh");
$("#cardcode").selectpicker("render");
<mobile-rows>
$("#mobile").val("${fld:mobile}");
</mobile-rows>
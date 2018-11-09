
var val = "<option value=''>--请选择--</option>";
var num = 0;
<rows>
	if(num<1){
		$("#custcode").val("${fld:custcode@js}");
	}
	num++;
	val+="<option value='${fld:code@js}'>${fld:name@js}</option>";
</rows>
if(num==0){
	ccms.dialog.alert("输入有误，未查询到该会员！");
}
$("#cardcode").html(val);
$("#cardcode").selectpicker("refresh");
$("#cardcode").selectpicker("render");
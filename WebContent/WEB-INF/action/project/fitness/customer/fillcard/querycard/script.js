
var val = "<option value=''>请选择</option>";
<rows>
	val+="<option value='${fld:code@js}'>${fld:name@js}</option>";
</rows>
$("#cardcode").html(val);

$("#cardcode").selectpicker("refresh");
$("#cardcode").selectpicker("render");
var count = 0;
<custrows>
count++;
$("#customercode").val("${fld:cust_code@js}");
$("#cust_name").val("${fld:cust_name@js}");
$("#mobile").val("${fld:mobile@js}");
$("#moneycash").val("${fld:moneycash}");
$("#moneygift").val("${fld:moneygift}");
</custrows>
if(count==0){
	$("#customercode,#cust_name,#mobile,#moneycash,#moneygift").val("");
	$("#cardcode").html("<option value=''>请选择</option>");
	ccms.dialog.alert("没有该会员！");
}

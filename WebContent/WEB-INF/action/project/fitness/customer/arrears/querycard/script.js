
var val = "<option value=''>请选择</option>";
<carddiscount-list>
	val+="<option value='${fld:discount}'>${fld:name@js}</option>";
</carddiscount-list>
$("#cardcode").html(val);

$("#cardcode").selectpicker("refresh");
$("#cardcode").selectpicker("render");

<custrows>
$("#customercode").val("${fld:cust_code@js}");
$("#cust_name").val("${fld:cust_name@js}");
$("#mobile").val("${fld:mobile@js}");
</custrows>
var moneycash="${fld:moneycash}";
var moneygift="${fld:moneygift}";
$("#span_moneycash").text(moneycash);
$("#span_moneygift").text(moneygift);

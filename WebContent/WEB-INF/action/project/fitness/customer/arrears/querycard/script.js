
var val = "<option value=''>请选择</option>";
<carddiscount-list>
	val+="<option code='${fld:code}' value='${fld:discount}'>${fld:name@js}</option>";
</carddiscount-list>
$("#cardcode").html(val);

$("#cardcode").selectpicker("refresh");
$("#cardcode").selectpicker("render");

<custrows>
$("#customercode").val("${fld:cust_code@js}");
$("#cust_name").val("${fld:cust_name@js}");
$("#mobile").val("${fld:mobile@js}");
</custrows>
var abin="${fld:moneycash}";
/*var moneygift="${fld:moneygift}";*/
$("#moneycash").text(abin);
/*$("#span_moneygift").text(moneygift);*/

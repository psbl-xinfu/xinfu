
//卡类型
var cardval = "<option value=''>--请选择--</option>";
<card-rows>
	cardval+="<option value='${fld:code@js}'>${fld:name@js}</option>";
</card-rows>
$("#cardcode").html(cardval);

$("#vc_code").val("${fld:code@js}");
$("#customercode").val("${fld:customercode@js}");
$("#cust").val("${fld:custname@js}");
setSelectValue($("#cardcode"), "${fld:cardcode@js}");
$("#classlistcode").val("${fld:classlistcode@js}");
ccms.util.setCheckboxValue('issank','${fld:issank}','formEditor');

$("#mobile").val("${fld:phone@js}");
<cardinfo-rows>
$("#nowcount").val("${fld:nowcount}");
$("#cardtype").val("${fld:typename@js}");
$("#carddate").html("${fld:startdate}~${fld:enddate}");
</cardinfo-rows>

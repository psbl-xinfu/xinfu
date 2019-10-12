

$("#vc_code").val("${fld:code@js}");
$("#cust").val("${fld:cardcode@js}");
$("#customercode").val("${fld:customercode@js}");
$("#cust_name").val("${fld:name@js}");
$("#mobile").val("${fld:mobile@js}");
$("#daysremain").val("${fld:nowcount}");
$("#remark").val("${fld:remark@js}");
$("#carddate").html("${fld:cardstartdate}~${fld:cardenddate}");

$("#moneycash").val("${fld:moneycash}");
$("#moneygift").val("${fld:moneygift}");
$("#cardcode").html("<option value='${fld:cardcode@js}'>${fld:cardtype@js}</option>");
if("${fld:cardstatus}"=="0"){
	$("#daysremain").parent().hide();
}
if("${fld:cardstatus}"=="1"){
	$("#carddate").parent().hide();
}

$("#cardcode").attr("disabled", true);

$("#cardcode").selectpicker("refresh");
$("#cardcode").selectpicker("render");

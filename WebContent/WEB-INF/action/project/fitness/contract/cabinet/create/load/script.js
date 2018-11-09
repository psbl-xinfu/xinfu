<contract-rows>
if( Number("${fld:status}") >= 2 ){
	topay("${fld:code}");
}
$("#contractcode").val("${fld:code}");
$("#customercode").val("${fld:customercode}");
$("#custnamespan").text("${fld:custname}");
$("#mobilespan").text("${fld:custmobile}");

$("#inimoney").val("${fld:inimoney}");
$("#inimoneyspan").text("${fld:inimoney}");
$("#normalmoney").val("${fld:normalmoney}");
$("#normalmoneyspan").text("${fld:normalmoney}");
$("#discountmoney").val((parseFloat("${fld:inimoney}")-parseFloat("${fld:normalmoney}")).toFixed(2));

price = parseFloat("${fld:price}");
setSelectValue($("#cabinet_group_id"), "${fld:groupid}");
$("#cabinetid").val("${fld:cabinetid}");
$("#cabinetcode").val("${fld:cabinetcode}");
$("#months").val("${fld:months}");

$("#begindate").val("${fld:begindate}");
$("#enddate").text("${fld:enddate}");
setSelectValue($("#salemember"), "${fld:salemember}");
setSelectValue($("#salemember1"), "${fld:salemember1}");
$("#remark").val("${fld:remark@js}");

</contract-rows>
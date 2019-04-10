<contract-rows>
if( Number("${fld:status}") >= 2 ){
	topay("${fld:code}");
}
$("#contractcode").val("${fld:code}");
$("#customercode").val("${fld:customercode}");
$("#custnamespan").text("${fld:custname}");
$("#mobilespan").text("${fld:custmobile}");

setSelectValue($("#salemember"), "${fld:salemember}");
setSelectValue($("#salemember1"), "${fld:salemember1}");
$("#remark").val("${fld:remark@js}");

</contract-rows>
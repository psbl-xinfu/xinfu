<contract-rows>
if( Number("${fld:status}") >= 2 ){
	topay("${fld:code}");
}
$("#contractcode").val("${fld:code}");
$("#relatecode").val("${fld:relatecode}");
$("#customercode").val("${fld:customercode}");

$("#salemember").val("${fld:salemember}");
$("#salemember1").val("${fld:salemember1}");
$("#remark").val("${fld:remark@js}");
</contract-rows>
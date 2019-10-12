<contract-rows>
if( Number("${fld:status}") >= 2 ){
	topay("${fld:code}");
}
$("#contractcode").val("${fld:code}");
$("#customercode").val("${fld:customercode}");
$("#custnamespan").text("${fld:custname}");
$("#mobilespan").text("${fld:custmobile}");

$("#recommendcode").val("${fld:recommendcode}");
$("#recommend").val("${fld:recommendname}");

$("#normalmoney").val("${fld:inimoney}");

$("#ptfee").val("${fld:ptfee}");
$("#ptfeespan").text("${fld:ptfee}");

setSelectValue($("#salemember"), "${fld:salemember}");
setSelectValue($("#salemember1"), "${fld:salemember1}");
setSelectValue($("#pt"), "${fld:pt}");
loadPtlevelByPT("${fld:pt}", function(){
	setSelectValue($("#ptlevelcode"), "${fld:ptlevelcode}");
});
setSelectValue($("#channel"), "${fld:source}");
$("#ptcount").val("${fld:ptcount}");
$("#ptenddate").val("${fld:ptenddate}");
$("#remark").val("${fld:remark@js}");
$("#ptamount").val("${fld:ptamounty}");
$("#channel").change();
$("#normalmoneyspan").text((Number("${fld:inimoney}")-Number("${fld:ptamounty}")));
</contract-rows>
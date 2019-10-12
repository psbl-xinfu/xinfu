<contract-rows>
if( Number("${fld:status}") >= 2 ){
	topay("${fld:code}");
}
$("#contractcode").val("${fld:code}");
$("#customercode").val("${fld:customercode}");
$("#custnamespan").text("${fld:custname}");
$("#mobilespan").text("${fld:custmobile}");

$("#giveday").val("${fld:giveday}");
$("#ptcount").val("${fld:ptcount}");
$("#daycount").val("${fld:daycount}");

setSelectValue($("#cardcode"), "${fld:cardcode}");
setSelectValue($("#cardtype"), "${fld:cardtype}");
$("#starttypespan").text("${fld:starttypename@js}");

setSelectValue($("#salemember"), "${fld:salemember}");
setSelectValue($("#salemember1"), "${fld:salemember1}");
$("#remark").val("${fld:remark@js}");
setSelectValue($("#mc"), "${fld:newmc}");
setSelectValue($("#starttype"), "${fld:starttype}");

$("#inimoney").val("${fld:inimoney}");
$("#inimoneyspan").text("${fld:inimoney}");
$("#normalmoney").val("${fld:normalmoney}");
$("#normalmoneyspan").text("${fld:normalmoney}");

cardfee = parseFloat("${fld:inimoney}");
days = parseInt("${fld:daycount}");
giveday = parseInt("${fld:giveday}");
ptcount = parseInt("${fld:ptcount}");

getAjaxCall("/action/project/fitness/contract/newcard/querycampaign?cardtype=${fld:cardtype}", true, function(){
	$("#campaigncode").val("${fld:campaigncode}");
	var discountStr = $("#campaigncode").find("option:selected").attr("code-discount");
	if( discountStr == "" || (!isNumber(discountStr) && !isFloat(discountStr)) ){
		discount = 1.00;
	}else{
		discount = parseFloat(discountStr).toFixed(2);
	}
	setcontractfee();
	$("#discountmoney").val("${fld:discountmoney}");
	getAjaxCall("/action/project/fitness/contract/upgrade/querycardinfo?cardcode=${fld:cardcode}", true, function(){
		$("#startdate").val("${fld:startdate}");
		$("#enddate").val("${fld:enddate}");
	});
});
</contract-rows>
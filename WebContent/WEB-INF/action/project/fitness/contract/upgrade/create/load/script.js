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
$("#startdate").val("${fld:startdate}");
$("#enddate").val("${fld:enddate}");

//折扣金额
$("#discountmoney").val("${fld:discountmoney}");
//补款金额
$("#fillingmoney").val("${fld:fillingmoney}");

setSelectValue($("#salemember"), "${fld:salemember}");
setSelectValue($("#salemember1"), "${fld:salemember1}");
setSelectValue($("#mc"), "${fld:newmc}");
$("#remark").val("${fld:remark@js}");

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
	getAjaxCall("/action/project/fitness/contract/upgrade/querycardinfo?cardcode=${fld:cardcode}", true, function(){
		cardfee = parseFloat("${fld:inimoney}")+parseFloat(oldnormalmoney);
		setcontractfee();
	});
});
</contract-rows>
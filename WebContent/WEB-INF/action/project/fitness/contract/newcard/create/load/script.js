<contract-rows>
if( Number("${fld:status}") >= 2 ){
	topay("${fld:code}");
}

//if("${fld:normalmoney}" == 2){ //储值卡隐藏部分div zzn
//	
//	$("div[code=starttype]").hide();;
//	$("div[code=give]").hide();
//	$("div[code=moneyleft]").show();
//	$("#moneyleftspan").text(moneyleft);
//	$("#moneyleft").val(moneyleft);
//	
//}else{
//	$("div[code=starttype]").show();;
//	$("div[code=give]").show();
//	$("div[code=moneyleft]").hide();
//}



$('#stage_times').attr('readonly',true);
$('#stagemoney').attr('readonly',true);
$('#discountmoney').attr('readonly',true);

$('#stage_times').unbind();
$('#stagemoney').unbind();

$("#contractcode").val("${fld:code}");
$("#customercode").val("${fld:customercode}");
$("#custnamespan").text("${fld:custname}");
$("#mobilespan").text("${fld:custmobile}");

$("#recommendcode").val("${fld:recommendcode}");
$("#recommend").val("${fld:recommendname}");

$("#inimoney").val("${fld:inimoney}");
$("#inimoneyspan").text("${fld:inimoney}");
$("#stagemoney").val("${fld:stagemoney}");
//分期
if("${fld:stagemoney}"!=0){
	$("#normalmoneyspan").text("${fld:stagemoney}");
	$("#shengyuqi").val("${fld:stage_times}"-"${fld:stage_times_pay}");
	
	var yingshouprice="${fld:normalmoney}";
	var benqiprice=$("#stagemoney").val();
	var finalprice=(yingshouprice-benqiprice)/("${fld:stage_times}"-"${fld:stage_times_pay}")
	$("#meiqiprice").text(finalprice.toFixed(3));
}else{
	$("#normalmoneyspan").text("${fld:normalmoney}");
}

$("#normalmoney").val("${fld:normalmoney}");


$("#discountmoney").val((parseFloat("${fld:inimoney}")-parseFloat("${fld:normalmoney}")).toFixed(2));


$("#headpic").attr("src", contextPath + "/action/project/fitness/util/attachment/download?tuid=${fld:custimgid}&type=1");
if( parseInt("${fld:stage_times}") > 1 ){
	$("div[code=stageDiv]").show();
	$("input[name=isstage]").iCheck("check");
}else{
	$("div[code=stageDiv]").hide();
}
$("#stage_times").val("${fld:stage_times}");
$("#giveday").val("${fld:giveday}");
$("#ptcount").val("${fld:ptcount}");
$("#daycount").val("${fld:daycount}");
setSelectValue($("#cardtype"), "${fld:cardtype}");
setSelectValue($("#starttype"), "${fld:starttype}");

loadCardType("${fld:cardtype}", function(){
	setSelectValue($("#campaigncode"), "${fld:campaigncode}");
	var discountStr = $("#campaigncode").find("option:selected").attr("code-discount");
	if( discountStr == "" || (!isNumber(discountStr) && !isFloat(discountStr)) ){
		discount = 1.00;
	}else{
		discount = parseFloat(discountStr).toFixed(2);
	}
});
$("#startdate").val("${fld:startdate}");
$("#enddate").val("${fld:enddate}");

setSelectValue($("#salemember"), "${fld:salemember}");
setSelectValue($("#salemember1"), "${fld:salemember1}");
$("#remark").val("${fld:remark@js}");

cardfee = parseFloat("${fld:inimoney}");
days = parseInt("${fld:daycount}");
giveday = parseInt("${fld:giveday}");
ptcount = parseInt("${fld:ptcount}");
$('#ptcountspan').text(ptcount);
stagetimes = parseInt("${fld:stage_times}");
setvaliddate();
$("#discountmoney").val("${fld:discountmoney}");
</contract-rows>
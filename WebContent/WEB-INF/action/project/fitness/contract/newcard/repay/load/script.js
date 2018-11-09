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

$("#inimoney").val("${fld:inimoney}");
var totalpaymoney = parseFloat("${fld:total_paymoney}");	// // 总已付金额
var leftmoney = (totalmoney - totalpaymoney).toFixed(2);	// 尚欠金额
var normalmoney = leftmoney;	// 应付金额

stagetimes = parseInt("${fld:stage_times}");
stage_times_pay = parseInt("${fld:stage_times_pay}");
if( stagetimes >= 2 ){
	$("input[name=isstage]").iCheck("check");
	$("div[code=stageDiv]").show();
	if( stagetimes != stage_times_pay ){
		normalmoney = (leftmoney/parseFloat(stagetimes-stage_times_pay)).toFixed(2);
	}
}else{
	$("input[name=isstage]").iCheck("uncheck");
	$("div[code=stageDiv]").hide();
}
$("input[name=isstage]").attr("disabled", true);
$("#normalmoneyspan").text("${fld:normalmoney}");
$("#normalmoney").val("${fld:normalmoney}");
$("#factmoney").val("${fld:normalmoney}");
$("#stagemoney").val("${fld:normalmoney}");
$("#stagemoneyspan").text("${fld:normalmoney}");

$("#stage_times_payspan").text("${fld:current_stage_times_pay}");
$("#stage_times_pay").val("${fld:current_stage_times_pay}");

$("#stagemoney").val("${fld:stagemoney}");
$("#stagemoney").val("${fld:stagemoney}");

$("#giveday").val("${fld:giveday}");
$("#ptcount").val("${fld:ptcount}");
$("#daycount").val("${fld:daycount}");

setSelectValue($("#salemember"), "${fld:salemember}");
setSelectValue($("#salemember1"), "${fld:salemember1}");
$("#remark").val("${fld:remark@js}");


</contract-rows>
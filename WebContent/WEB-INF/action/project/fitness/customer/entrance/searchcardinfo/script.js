
$("#custcode").html("${fld:code@js}");
$("#name").html("${fld:name@js}");
$("#mobile").html("${fld:mobile@js}");
$("#mc").html("${fld:mc@js}");
$("#pt").html("${fld:pt@js}");
$("#cabinettempcode").html("${fld:cabinettempcode@js}");
$("#rudge_code").val("${fld:cabinettempcode@js}");
$("#cust_code").val("${fld:cust_code@js}");
$("#cust_name").val("${fld:name@js}");
$("#custcodeone").html("${fld:code@js}");
$("#cardtype_name").html("${fld:cardtype_name@js}");
var moneyleft = "${fld:moneyleft}";
if("${fld:type}"=="0"){
	$("#errorinfo").html("时效卡");
}else if("${fld:type}"=="1"){
	$("#errorinfo").html("此卡有效,次数剩余${fld:nowcount}次！");
}else if("${fld:type}"=="2"){
	$("#errorinfo").html("基金卡");
} 
$(".error").html("");
if(Number(moneyleft)>0){
	$("#errorinfo").append("/欠款金额："+moneyleft);
}
////后台设置多少天未锻炼前台刷卡时提示  zzn 注释掉
//if(parseInt("${fld:inleftnum}")==0){
//	$("#errorinfo").append("，该卡${fld:foreremind}天未锻炼");
//}

//商品购买欠费
if(Number("${fld:factmoney}")>0){
	$("#errorinfo").append("，您购买的商品有未还款金额，欠款${fld:factmoney}元");
}
//单次消费欠费
if(Number("${fld:normalmoney}")>0){
	$("#errorinfo").append("，您单次消费有未还款金额，欠款${fld:normalmoney}元");
}


if( "" != "${fld:imgid}" ){
	$("#headpic").attr("src", contextPath+"/action/project/fitness/util/attachment/download?tuid=${fld:imgid}&type=1");
}else{
	$("#headpic").attr("src", contextPath+"/js/project/fitness/image/SVG/170X220.svg");
}

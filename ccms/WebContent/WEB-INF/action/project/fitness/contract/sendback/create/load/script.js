var cardobj = $("#cardcode");
cardobj.empty();
cardobj.append('<option value="">请选择</option>');
<custcard-rows>
cardobj.append('<option code="${fld:contractcode@js}" value="${fld:code}">${fld:code@js}${fld:isgoonname}</option>');
</custcard-rows>

<contract-rows>
if( Number("${fld:status}") >= 2 ){
	topay("${fld:code}");
}
$("#contractcode").val("${fld:code}");
$("#customercode").val("${fld:customercode}");
$("#custnamespan").text("${fld:custname}");
$("#mobilespan").text("${fld:custmobile}");

$("#normalmoney").val("${fld:normalmoney}");

cardobj.val("${fld:cardcode}");
$("#cardcode").selectpicker("refresh");
$("#cardcode").selectpicker("render");
$("#cardcontractcode").val("${fld:cardcontractcode}");
$("#cardtypespan").text("${fld:cardtypename@js}");
$("#startdatespan").text("${fld:startdate}");
$("#enddatespan").text("${fld:enddate}");
$("#nowcountspan").text("${fld:nowcount}");
$("#countspan").text("${fld:count}");

$("#inimoneyspan").text("${fld:oldinimoney}");
$("#oldinimoney").val("${fld:oldinimoney}");
$("#normalmoneyspan").text("${fld:oldnormalmoney}");
$("#oldnormalmoney").val("${fld:oldnormalmoney}");
$("#leftmoneyspan").text("${fld:oldleftmoney}");
$("#leftmoney").val("${fld:oldleftmoney}");
$("#moneyleftspan").text("${fld:oldmoneyleft}");
$("#moneyleft").val("${fld:oldmoneyleft}");
$("#usedays").val("${fld:usedays}");
if( Number("${fld:count}") > 0 ){
	$("#countDiv").show();
}else{
	$("#countDiv").hide();
}

$("#salemember").val("${fld:salemember}");
$("#remark").val("${fld:remark@js}");
</contract-rows>
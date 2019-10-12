<card-rows>
$("#cardtypespan").text("${fld:cardtypename@js}");
$("#startdatespan").text("${fld:startdate}");
$("#enddatespan").text("${fld:enddate}");
$("#nowcountspan").text("${fld:nowcount}");
$("#countspan").text("${fld:count}");
$("#inimoneyspan").text("${fld:inimoney}");
$("#normalmoneyspan").text("${fld:normalmoney}");
$("#leftmoneyspan").text("${fld:leftmoney}");
$("#moneyleftspan").text("${fld:moneyleft}");

$("#oldinimoney").val("${fld:inimoney}");
$("#oldnormalmoney").val("${fld:normalmoney}");
$("#leftmoney").val("${fld:leftmoney}");
$("#moneyleft").val("${fld:moneyleft}");
$("#usedays").val("${fld:usedays}");
if( Number("${fld:count}") > 0 ){
	$("#countDiv").show();
}else{
	$("#countDiv").hide();
}
</card-rows>

$("#cardstartdate").val("${fld:startdate}");
$("#cardenddate").val("${fld:enddate}");
$("#carddate").html("${fld:startdate}~${fld:enddate}");
$("#daysremain").val("${fld:nowcount}");

if("${fld:cardtype}"=="0"){
	$("#daysremain").parent().hide();
}
if("${fld:cardtype}"=="1"){
	$("#carddate").parent().hide();
}

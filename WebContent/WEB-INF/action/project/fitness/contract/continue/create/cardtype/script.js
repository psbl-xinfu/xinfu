var ptstr="";
<cardtype-rows>
	ptstr+="<option value='${fld:code}' code='${fld:cardfee}' codeday='${fld:daycount}' codegiveday='${fld:giveday}' codept='${fld:ptcount}'>${fld:name@js}</option>"
</cardtype-rows>
$("#cardtype").html(ptstr);
$("#cardtype").selectpicker("val", "1943");
$("#cardtype").selectpicker("refresh");
$("#cardtype").selectpicker("render");


var ptstr = "<option value=''>全部教练</option>";
<rows>
	console.log("${fld:name}");
	ptstr+="<option value='${fld:userlogin}'>${fld:name}</option>"
</rows>
$("#turnclasspt").html(ptstr);

$("#turnclasspt").selectpicker("refresh");
$("#turnclasspt").selectpicker("render");


var ptstr = "<option value=''>全部会籍</option>";
<rows>
	ptstr+="<option value='${fld:userlogin}'>${fld:name}</option>"
</rows>
$("#turnclasspt").html(ptstr);

$("#turnclasspt").selectpicker("refresh");
$("#turnclasspt").selectpicker("render");

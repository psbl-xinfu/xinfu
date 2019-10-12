
var html = "";
<rows>
	html+="<tr><td>${fld:ptlevelname@js}</td><td>${fld:staff_name@js}</td>"
		+"<td>1课时</td><td>${fld:ptleftcount}</td><td>${fld:preparedate@yyyy-MM-dd HH:mm}</td><td>${fld:createdby}</td></tr>";
</rows>
$("#custptprepare").html(html);




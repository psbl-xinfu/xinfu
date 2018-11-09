
var str = "";
<rows>
	str+="<div><div class='lt'><img src='${def:context}/js/project/fitness/wx/image/team/remark.png' />"
		+"</div><div class='rt tip'><p>${fld:prepare_date}</p><p>"
		+"${fld:org_name}${fld:sitename}，${fld:prepare_starttime}~${fld:prepare_endtime}</p></div></div>";
</rows>
$("#siteusedetail").html(str);
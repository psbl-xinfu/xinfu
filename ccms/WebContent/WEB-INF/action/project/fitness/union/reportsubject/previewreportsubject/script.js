var shourutypenum = 0, zhichutypenum = 0;
var str = "<tr>";
//收入
<shouruone-rows>
	str+="<th colspan='${fld:count}'>${fld:subjectname}</th>";
	shourutypenum+=parseInt('${fld:count}');
</shouruone-rows>
//支出
<zhichuone-rows>
str+="<th colspan='${fld:count}'>${fld:subjectname}</th>";
	zhichutypenum+=parseInt('${fld:count}');
</zhichuone-rows>

str += "</tr><tr>";
<shourutwo-rows>
	str+="<th colspan='${fld:count}'>${fld:subjectname}</th>";
</shourutwo-rows>
<zhichutwo-rows>
str+="<th colspan='${fld:count}'>${fld:subjectname}</th>";
</zhichutwo-rows>

str += "</tr><tr>";
<shouruthree-rows>
	str+="<th colspan='${fld:count}'>${fld:subjectname}</th>";
</shouruthree-rows>
<zhichuthree-rows>
str+="<th colspan='${fld:count}'>${fld:subjectname}</th>";
</zhichuthree-rows>

str += "</tr><tr>";
<shourufour-rows>
	str+="<th colspan='${fld:count}'>${fld:subjectname}</th>";
</shourufour-rows>
<zhichufour-rows>
str+="<th colspan='${fld:count}'>${fld:subjectname}</th>";
</zhichufour-rows>
$("#report_subject").append(str+"</tr>");






var ptreststr = "";
<ptrest-rows>
	var percentage = Number(parseInt("${fld:num}")/parseInt("${fld:pttotalcount}")*100).toFixed(2);
	ptreststr+="<tr><td>${fld:ptlevelname}</td><td>${fld:name}</td><td>${fld:pttype}</td>"
		+"<td>${fld:pttotalcount}</td><td>${fld:ptleftcount}</td><td>"+percentage+"%</td></tr>";
</ptrest-rows>
$("#ptreststr").html(ptreststr);




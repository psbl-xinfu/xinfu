
var ptrestlist = "", count = 0;
<rows>
	count++;
	ptrestlist+="<tr>"
			+"<td>"+count+"</td><td>${fld:code}</td><td>${fld:name}</td><td>${fld:mobile}</td>"
			+"<td>${fld:pttotalcount}</td><td>${fld:ptleftcount}</td><td>${fld:type}</td><td>${fld:status}</td>"
			+"<td>${fld:ptname}</td><td>${fld:enddate}</td><td>${fld:pttype}</td>";
</rows>
$("#ptrestlist").html(ptrestlist);
ccms.util.renderRadio("ptrestcode");

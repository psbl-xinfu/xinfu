
var ptrestlist = "", count = 0;
<rows>
	count++;
	ptrestlist+="<tr><td class='table-checkbox'><input type='radio' name='ptrestcode' value='${fld:code}'></td>"
			+"<td>"+count+"</td><td>${fld:ptlevelname}</td><td>${fld:pttotalcount}</td><td>${fld:ptleftcount}</td>"
			+"<td>${fld:ptnormalmoney}</td><td>${fld:ptmoney}</td><td>${fld:ptfee}</td><td>${fld:ptfactfee}</td>"
			+"<td>${fld:scale}</td><td>${fld:ptname}</td><td>${fld:ptenddate}</td><td>${fld:pttype}</td>";
</rows>
$("#ptrestlist").html(ptrestlist);
ccms.util.renderRadio("ptrestcode");

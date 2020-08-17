var thecodes;
<thecodes>
	thecodes="${fld:thecodes}";
	$("#yuanmc").val("${fld:mc}");
	$("#contents").val("${fld:contents}");
</thecodes>



var ptrestlist = "", count = 0;
<rows>
	count++;
	ptrestlist+="<tr>"
			+"<td>"+count+"</td><td>${fld:thename}</td><td>${fld:i_sex}</td><td>${fld:mobile}</td>"
			+"<td>${fld:storename}</td><td>${fld:posname}</td><td>${fld:officename}</td><td>${fld:mcname}</td></tr>"
</rows>
$("#ptrestlist").html(ptrestlist);
ccms.util.renderRadio("ptrestcode");


/*var thecodes;
<thecodes>
	thecodes="${fld:thecodes}";
</thecodes>
*/


var ptrestlist = "", count = 0;

<rows>
	$("#ccguestcode").val("${fld:gtcode}");
	count++;
	ptrestlist+="<tr>"
			+"<td>"+count+"</td><td>${fld:thename}</td><td>${fld:i_sex}</td><td>${fld:mobile}</td>"
			+"<td>${fld:posname}</td><td>${fld:officename}</td><td>${fld:mcname}</td></tr>"
</rows>
$("#ptrestlist").html(ptrestlist);
ccms.util.renderRadio("ptrestcode");


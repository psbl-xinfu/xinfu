
var cardrestlist = "", cardcount = 0;
<rows>
	cardcount++;
	cardrestlist+="<tr>"
		+"<input id='salemember"+cardcount+"' name='salemember'  type='hidden' value='${fld:salemember}'/>"
		+"<input id='htcode"+cardcount+"' name='htcode'  type='hidden' value='${fld:htcode}'/>"
			+"<td>"+cardcount+"</td><td>${fld:code}</td><td>${fld:name}</td><td>${fld:concode}</td>"
			+"<td>${fld:type}</td><td>${fld:cardname}</td><td>${fld:status}</td><td>${fld:mcname}</td>"
			+"<td>${fld:enddate}</td>"
			+"</tr>";
</rows>
$("#cardrestlist").html(cardrestlist);
ccms.util.renderRadio("ptrestcode");

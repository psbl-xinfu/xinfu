var cardrestlist = "", cardcount = 0;
<rows>
	cardcount++;
	cardrestlist+="<tr>"
		+"<input id='salemember"+cardcount+"' name='salemember'  type='hidden' value='${fld:salemember}'/>"
		+"<input id='htcode"+cardcount+"' name='htcode'  type='hidden' value='${fld:htcode}'/>"
		+"<input id='yuan"+cardcount+"' name='yuan'  type='hidden' value='${fld:yuan}'/>"
		+"<input id='cardtypecode"+cardcount+"' name='cardtypecode'  type='hidden' value='${fld:cardtypecode}'/>"
		+"<td id='shixiaotd"+cardcount+"' style='display: none;'><select id='shixiao"+cardcount+"' name='shixiao'>"
		+"<shixiao-rows>"
		+"<option value='${fld:shixiaocardtypecode}'>${fld:shixiaocardtypename}</option>"
		+"</shixiao-rows></td>"
		+"<td id='jicitd"+cardcount+"' style='display: none;'><select id='jici"+cardcount+"' name='jici'>"
		+"<jici-rows>"
		+"<option value='${fld:jicicardtypecode}'>${fld:jicicardtypename}</option>"
		+"</jici-rows></td>"
			+"<td>"+cardcount+"</td><td id='cardcode"+cardcount+"'>${fld:code}</td><td>${fld:name}</td><td>${fld:concode}</td>"
			+"<td>${fld:type}</td><td'>${fld:cardname}</td><td id='xiancardname"+cardcount+"'>"
			+"</td><td>${fld:status}</td><td>${fld:mcname}</td>"
			+"<td>${fld:enddate}</td>"
			+"</tr>";
</rows>
$("#cardrestlist").html(cardrestlist);

ccms.util.renderRadio("ptrestcode");

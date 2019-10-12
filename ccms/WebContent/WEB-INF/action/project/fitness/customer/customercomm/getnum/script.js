var str="";
<row>		
	str+='<tr><td >${fld:application_id@js}</td>';
	str+='<td >${fld:name@js}</td>';
	str+='<td >${fld:kefu1}</td>';
	str+='<td >${fld:kefu2}</td></tr> ';
</row>
	$('#data').html(str);
	ccms.util.renderRadio("datalist2");
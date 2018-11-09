
var count = 0;
var html = "";
<rows>
	count++;
	html+='<tr><td><input type="radio" ';
	if(count==1){
		html+='checked="checked" ';
	}
	html+='class="classprepare" name="classprepare" value="${fld:code@js}"></td>'
		+"<td>${fld:class_name@js}</td><td>${fld:classdate}</td><td>${fld:classroom_name@js}</td><td>${fld:staff_name@js}</td></tr>";
</rows>
$("#classdef").html(html);

ccms.util.renderRadio("classprepare");


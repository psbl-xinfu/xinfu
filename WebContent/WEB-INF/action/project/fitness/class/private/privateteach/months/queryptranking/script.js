
var str = "", count = 0;
<rows>
	count++;
	var type = "<img src='${def:context}/js/project/fitness/image/SVG/index/";
	if(count==1)type+="one.svg'>";
	if(count==2)type+="two.svg'>";
	if(count==3)type+="three.svg'>";
	if(count==4)type="4";
	str+="<tr><td><img src='${def:context}/js/project/fitness/image/SVG/50X50.svg'></td>"
		+"<td class='name'>${fld:name@js}</td><td>${fld:num}</td>"
		+"<td>"+type+"</td></tr>";
</rows>
$("#ptranking").html(str);

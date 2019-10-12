var strhtml = "";
var count = 0;
<list-rows>
	count++;
	strhtml+="<tr id='list'>"
			+"<td>${fld:cardtypename@js}</td>"
			+"<td>${fld:status@js}</td>"
			+"<td>${fld:code@js}</td>"
			+"<td>${fld:name@js}</td>"
			+"<td>${fld:mobile@js}</td>"
//			+"<td>${fld:normalmoney}</td>"
			+"<td>${fld:factmoney}</td>"
			+"<td>${fld:startdate}</td>"
			+"<td>${fld:enddate}</td>"
			+"<td>${fld:createdby@js}</td>"
			+"</tr>";
</list-rows>
if(count==0){
	strhtml+="<tr>";
	strhtml+="<td class='text-center' colspan=12><span style='color:red;font-size:large;'>没有记录</span></td>";
	strhtml+="</tr>";
}
$("#datagrid").html(strhtml);




var strhtml = "";
var count = 0;
<list-rows>
	count++;
	strhtml+="<tr id='list'>"
			+"<td>${fld:cardtype@js}</td>"
			+"<td>${fld:status@js}</td>"
			+"<td>${fld:oldcardcode@js}</td>"
			+"<td>${fld:cardcode@js}</td>"
			+"<td>${fld:cust_name@js}</td>"
			+"<td>${fld:mobile}</td>"
			+"<td>${fld:money}</td>"
			+"<td>${fld:created}</td>"
			+"<td>${fld:createdby@js}</td>"
			+"</tr>";
</list-rows>
if(count==0){
	strhtml+="<tr>";
	strhtml+="<td class='text-center' colspan=12><span style='color:red;font-size:large;'>没有记录</span></td>";
	strhtml+="</tr>";
}
$("#datagrid").html(strhtml);

var strhtml = "";
var count = 0;
<list-rows>
	count++;
	strhtml+="<tr id='list'>"
			+"<td>${fld:code@js}</td>"
			+"<td>${fld:card_code@js}</td>"
			+"<td>${fld:name@js}</td>"
			+"<td>${fld:mobile@js}</td>"
			+"<td>${fld:net_code@js}</td>"
			+"<td>${fld:factmoney}</td>"
			+"<td>${fld:net_start}</td>"
			+"<td>${fld:net_end}</td>"
			+"<td>${fld:remark@js}</td>"
			+"<td>${fld:createdby}</td>"
			+"<td>${fld:salemember}</td>"
			+"</tr>";
</list-rows>
if(count==0){
	strhtml+="<tr>";
	strhtml+="<td class='text-center' colspan=12><span style='color:red;font-size:large;'>没有记录</span></td>";
	strhtml+="</tr>";
}
$("#datagrid").html(strhtml);



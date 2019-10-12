var strhtml = "";
var count = 0;
<cust-rows>
	count++;
	strhtml+="<tr id='list'>"
			+"<td>${fld:custcode@js}</td>"
			+"<td>${fld:name@js}</td>"
			+"<td>${fld:mobile@js}</td>"
			+"<td>${fld:pt_name@js}</td>"
			+"<td>${fld:created@yyyy-MM-dd HH:mm:ss}</td>"
			+"<td>${fld:remark@js}</td>"
			+"<td><button type='button' onclick=findguest('${fld:code}')>查看</button></td>"
			+"</tr>";
</cust-rows>
if(count==0){
	strhtml+="<tr>";
	strhtml+="<td class='text-center' colspan=12><span style='color:red;font-size:large;'>没有记录</span></td>";
	strhtml+="</tr>";
}
$("#datagrid").html(strhtml);

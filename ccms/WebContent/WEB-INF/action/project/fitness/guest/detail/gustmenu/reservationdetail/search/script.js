var strhtml = "";
var count = 0;
<cust-rows>
	count++;
	strhtml+="<tr id='list'>"
			+"<td>${fld:prepare_time}</td>"
			+"<td>${fld:pt_name@js}</td>"
			+"<td>${fld:vc_name@js}</td>"
			+"<td>${fld:ptlevelname@js}</td>"
			+"<td>${fld:i_statusname@js}</td>"
			+"<td>${fld:c_itime@yyyy-MM-dd HH:mm:ss}</td>"
			+"<td>${fld:f_ptfee}</td>"
			+"<td>${fld:f_leftcount}</td>"
			+"</tr>";
</cust-rows>
if(count==0){
	strhtml+="<tr>";
	strhtml+="<td class='text-center' colspan=12><span style='color:red;font-size:large;'>没有记录</span></td>";
	strhtml+="</tr>";
}
$("#datagrid").html(strhtml);

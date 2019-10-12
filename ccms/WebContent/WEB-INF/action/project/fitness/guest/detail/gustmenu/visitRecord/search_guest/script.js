var str='';
var a=0;
<order-rows>
    a++;
    str+='<tr>';
	str += '<td  >${fld:visitdate} ${fld:visittime}</td>';
	str += '<td  >${fld:mc}</td>';
	/*str += '<td  >${fld:status}</td>';*/
	str += '<td  >${fld:t_remark}</td>';
	str += '<td  >${fld:createdby@js}</td>';
	str += '<td  >${fld:created}</td>';
	str+='</tr>';
</order-rows>
if(a==0){
	str+="<tr>";
	str+="<td class='text-center' colspan=10><span style='color:red;font-size:large;'>没有记录</span></td>";
	str+="</tr>";
}
$("#datagrid").html(str);
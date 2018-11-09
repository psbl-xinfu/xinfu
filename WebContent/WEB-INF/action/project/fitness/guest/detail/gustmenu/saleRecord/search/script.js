var str='';
var a=0;
<order-rows>
    a++;
    str+='<tr>';
	str += '<td  >${fld:type}</td>';
	str += '<td  >${fld:normalmoney}</td>';
	str += '<td  >${fld:prepaid}</td>';
	str += '<td  >${fld:amount_owe}</td>';
	str += '<td  >${fld:vc_iuser}</td>';
	str += '<td  >${fld:createdate} ${fld:createtime}</td>';
	str += '<td  >${fld:status}</td>';
	str+='</tr>';
</order-rows>
if(a==0){
	str+="<tr>";
	str+="<td class='text-center' colspan=10><span style='color:red;font-size:large;'>没有记录</span></td>";
	str+="</tr>";
}
$("#datagrid").html(str);
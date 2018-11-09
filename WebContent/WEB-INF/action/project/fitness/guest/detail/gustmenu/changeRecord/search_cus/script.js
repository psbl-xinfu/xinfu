var str='';
var a=0;
<order-rows>
    a++;
    str+='<tr>';
	str += '<td  >${fld:field_name}</td>';
	str += '<td  >${fld:before_value}</td>';
	str += '<td  >${fld:after_value}</td>';
	str += '<td  >${fld:createdby@js}</td>';
	str += '<td  >${fld:created@yyyy-MM-dd HH:mm:ss}</td>';
	str += '<td  >${fld:t_remark}</td>';
	str+='</tr>';
</order-rows>
if(a==0){
	str+="<tr>";
	str+="<td class='text-center' colspan=10><span style='color:red;font-size:large;'>没有记录</span></td>";
	str+="</tr>";
}
$("#datagrid").html(str);
var str='';
var a=0;
<order-rows>
    a++;
    str+='<tr>';
	str += '<td  >${fld:vc_oldmc@js}</td>';
	str += '<td  >${fld:vc_newmc@js}</td>';
	str += '<td  >${fld:vc_remark}</td>';
	str += '<td  >${fld:vc_iuser@js}</td>';
	str += '<td  >${fld:vc_itime}</td>';
	str+='</tr>';
</order-rows>
if(a==0){
	str+="<tr>";
	str+="<td class='text-center' colspan=10><span style='color:red;font-size:large;'>没有记录</span></td>";
	str+="</tr>";
}
$("#datagrid").html(str);
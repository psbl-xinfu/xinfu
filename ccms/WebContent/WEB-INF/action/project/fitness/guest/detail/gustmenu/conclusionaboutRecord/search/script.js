var str='';
var a=0;
<order-rows>
    a++;
    str+='<tr>';
	str += '<td class="text-center">${fld:class_name}</td>';
	str += '<td class="text-center">${fld:arrivetime}</td>';
	str += '<td class="text-center">${fld:status}</td>';
	str += '<td class="text-center">${fld:vc_iuser}</td>';
	str += '<td class="text-center">${fld:created}</td>';
	str+='</tr>';
</order-rows>
if(a==0){
	str+="<tr>";
	str+="<td class='text-center' colspan=10><span style='color:red;font-size:large;'>没有记录</span></td>";
	str+="</tr>";
}
$("#datagrid").html(str);
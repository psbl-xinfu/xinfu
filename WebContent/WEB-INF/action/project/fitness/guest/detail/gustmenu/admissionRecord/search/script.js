var str='';
var a=0;
<order-rows>
    a++;
    str+='<tr>';
	str += '<td>${fld:itemtype}</td>';
	str += '<td>${fld:cardcode}</td>';
	str += '<td>${fld:bringother}</td>';
	str += '<td>${fld:intime@yyyy-MM-dd HH:mm:ss}</td>';
	str += '<td>${fld:inuser}</td>';
	str += '<td>${fld:lefttime@yyyy-MM-dd HH:mm:ss}</td>';
	str += '<td>${fld:leftuser}</td>';
	str += '<td>${fld:remark}</td>';
	str+='</tr>';
</order-rows>
if(a==0){
	str+="<tr>";
	str+="<td class='text-center' colspan=10><span style='color:red;font-size:large;'>没有记录</span></td>";
	str+="</tr>";
}
$("#datagrid").html(str);
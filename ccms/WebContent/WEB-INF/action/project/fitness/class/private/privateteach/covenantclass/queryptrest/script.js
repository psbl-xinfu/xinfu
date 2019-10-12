
var val = "";
var num = 0;
<rows>
	num++;
	val+="<tr><td class='text-center'><input type='radio' class='form-control' value='${fld:code@js}' name='ptcode'/></td>";
	val+="<td class='text-center'>"+num+"</td>";
	val+="<td class='text-center'>${fld:ptlevelname@js}</td>";
	val+="<td class='text-center'>${fld:ptleftcount}</td>";
	val+="<td class='text-center'>${fld:staffname@js}</td>";
	val+="<td class='text-center'>${fld:ptstatus@js}</td>";
	val+="<td class='text-center'>${fld:ptfee}</td></tr>";
</rows>
$("#ptrest").html(val);
$("#ptcount").val(num);
ccms.util.renderRadio("ptcode");
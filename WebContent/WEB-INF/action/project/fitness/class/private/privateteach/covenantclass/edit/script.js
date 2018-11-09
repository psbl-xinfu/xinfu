
//课程
var ptrestval = "";
var num = 0;
<ptrest-rows>
	num++;
	ptrestval+="<tr><td class='text-center'><input type='radio' class='form-control' value='${fld:code}' name='ptcode'/></td>";
	ptrestval+="<td class='text-center'>"+num+"</td>";
	ptrestval+="<td class='text-center'>${fld:ptlevelname}</td>";
	ptrestval+="<td class='text-center'>${fld:ptleftcount}</td>";
	ptrestval+="<td class='text-center'>${fld:staffname}</td>";
	ptrestval+="<td class='text-center'>${fld:ptfee}</td></tr>";
</ptrest-rows>
$("#ptrest").html(ptrestval);

//预约
document.formEditor.code.value="${fld:code}";
document.formEditor.custall.value="${fld:customercode}";
document.formEditor.pdate.value="${fld:preparedate}";

//预约时间（时 分）
var preparetime = "${fld:preparetime}";
var val = preparetime.split(":");
document.formEditor.hour.value=parseInt(val[0]);
document.formEditor.minute.value=val[1];

ccms.util.setCheckboxValue('ptcode','${fld:ptrestcode}','formEditor');

//会籍时间
$("#startenddate").html("${fld:enddate}");

ccms.util.renderRadio("ptcode");

$("#hour,#minute").selectpicker("refresh");
$("#hour,#minute").selectpicker("render");



document.formEditor.code.value = "${fld:code@js}";
document.formEditor.ptlevelname.value = "${fld:ptlevelname@js}";
document.formEditor.ptfee.value = "${fld:ptfee}";
document.formEditor.ptfee.value = "${fld:ptfee}";
document.formEditor.scale.value = "${fld:scale}";
document.formEditor.remark.value = "${fld:remark@js}";
document.formEditor.times.value = "${fld:times}";
ccms.util.setCheckboxValue('isgroup',"${fld:isgroup}","formEditor");
if("${fld:spacing}"=="0"){
	setSelectValue($("#spacing"), "00");
}else{
	setSelectValue($("#spacing"), "${fld:spacing}");
}
setSelectValue($("#reatetype"), "${fld:reatetype}");
setSelectValue($("#status"), "${fld:status}");

var val = "";
<rows>
	val+="<li><input type='text' size='2' name='startcount' value='${fld:startcount}' placeholder='课程开始'/></li>"
		+"<li>课时至<input type='text' size='2' name='endcount' value='${fld:endcount}' placeholder='课程结束'/></li><li>课时，"+
		"折扣<input type='text' size='2' name='reate' value='${fld:reate}' placeholder='百分比'/>%"
		+"&nbsp;&nbsp;&nbsp;&nbsp;<img src='${def:context}/js/project/fitness/image/SVG/nav/shanchu.svg' style='width: 15px;height: 15px;' title='删除' onclick='delhour(this)'/></li>";
</rows>
$("#hour").html(val);
<rows-limit>
	ccms.util.setCheckboxValue('pt','${fld:pt}','formEditor');
</rows-limit>
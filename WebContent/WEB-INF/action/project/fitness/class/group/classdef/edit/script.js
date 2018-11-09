document.formEditor.vc_code.value = "${fld:code@js}";
document.formEditor.class_name.value = "${fld:class_name@js}";
document.formEditor.class_ename.value="${fld:class_ename@js}";
document.formEditor.times.value="${fld:times}";
document.formEditor.class_bgcolor.value="${fld:class_bgcolor@js}";
document.formEditor.class_bgcolor.style.backgroundColor = "#${fld:class_bgcolor}";
ccms.util.setCheckboxValue('islimitroom','${fld:islimitroom}','formEditor');
if('${fld:islimitroom}'=='1'){
	setSelectValue($("#classroomcode"), "${fld:classroomcode}");
}
ccms.util.setCheckboxValue('isprepare','${fld:isprepare}','formEditor');
if('${fld:allowbeginbook}'==""||'${fld:allowbeginbook}'=='0'){
	ccms.util.setCheckboxValue('isallowbeginbook',0,'formEditor');
}else{
	ccms.util.setCheckboxValue('isallowbeginbook',1,'formEditor');
	$("#allowbeginbook").val(Math.floor(parseFloat('${fld:allowbeginbook}')/60*100)/100);
}
if('${fld:isprepare}'=='1'){
	$("#allowbook").val(Math.floor(parseFloat('${fld:allowbook}')/60*100)/100);
	$("#mincount").val('${fld:mincount}');
}
document.formEditor.classinfo.value="${fld:classinfo@js}";
setSelectValue($("#status"), "${fld:status}");

<rows-limit>
	ccms.util.setCheckboxValue('teachercode','${fld:teachercode}','formEditor');
</rows-limit>
<num-rows>
$("#limit_num").val("${fld:limit_num}");
</num-rows>

$("#price").html("${fld:classfee}");
ccms.util.setCheckboxValue('isprepare','${fld:isprepare}','formEditor');
document.formEditor.color.value="${fld:class_bgcolor@js}";
document.formEditor.color.style.backgroundColor = "#${fld:class_bgcolor}";
$("#class_ename").html("${fld:class_ename}");
$("#endtime").val("${fld:times}");
$("#timeslen").val("${fld:timeslen}");

$("#classroomcode option").css("display", "none");
if("${fld:classroomcode}"==""){
	$("#classroomcode option").css("display", "block");
}else{
	$("#classroomcode option[value='${fld:classroomcode}']").css("display", "block");
	$("#classroomcode option[value='']").css("display", "block");
}
setSelectValue($("#classroomcode"), "");
$("#classroomcode").change();

var count = 0;
$("#teacherid option").css("display", "none");
<limit-rows>
	count++;
	$("#teacherid option[value=${fld:teachercode}]").css("display", "block");
</limit-rows>
$("#teacherid option[value='']").css("display", "block");
if(count==0){
	$("#teacherid option").css("display", "block");
}
setSelectValue($("#teacherid"), "");
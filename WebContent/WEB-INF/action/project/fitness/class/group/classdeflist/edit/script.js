
document.formEditor.vc_code.value="${fld:code}";
document.formEditor.classcode.value="${fld:classcode}";
document.formEditor.classdate.value="${fld:classdate}";
document.formEditor.classtime.value="${fld:classtime}";
document.formEditor.status.value="${fld:status}";
document.formEditor.remark.value="${fld:remark}";


if("${fld:crcode}"==""){
	$("#classroomcode option").css("display", "block");
}else{
	$("#classroomcode option[value='${fld:crcode}']").css("display", "block");
	$("#classroomcode option[value='']").css("display", "block");
}
setSelectValue($("#classroomcode"), "${fld:classroomcode}");
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
document.formEditor.teacherid.value="${fld:teacherid}";

//查询课程信息
$("#price").html("${fld:classfee}");
ccms.util.setCheckboxValue('isprepare','${fld:isprepare}','formEditor');
document.formEditor.color.value="${fld:class_bgcolor@js}";
document.formEditor.color.style.backgroundColor = "#${fld:class_bgcolor}";
$("#class_ename").html("${fld:class_ename}");
$("#endtime").val("${fld:times}");
$("#timeslen").val("${fld:timeslen}");

<classroomnum-rows>
//查询可容纳人的数量
$("#limitcount").val("${fld:limit_num}");
</classroomnum-rows>
if("${fld:status}"=="1"){
	$("#save_btn").hide();
}
$("#classcode,#classroomcode,#teacherid").selectpicker("refresh");
$("#classcode,#classroomcode,#teacherid").selectpicker("render");


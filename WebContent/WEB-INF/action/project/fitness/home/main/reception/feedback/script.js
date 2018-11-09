//今日客诉提醒
$("#todaynum").html("${fld:todaynum}");

var str = "", count=0, nofeedbackcount = 0;
<feedback-rows>
	count++;
	var imgid = "", updatedate="", fkclass="active", btnname="处理";
	if("${fld:imgid}"==""){
		imgid = "${def:context}/js/project/fitness/image/SVG/50X50.svg";
	}else{
		imgid = "${def:context}/action/project/fitness/util/attachment/download?tuid=${fld:imgid}&type=1";
	}
	if("${fld:status}"!="1"){
		updatedate = "${fld:updated@yyyy-MM-dd HH:mm}";
		fkclass = "has";
		btnname="已处理";
	}else{
		nofeedbackcount++;
	}
	str += "<tr><td>"+count+"</td><td><img src='"+imgid+"' alt=''>"
		+"</td><td class='color-1'>${fld:name@js}</td><td>${fld:mobile@js}</td>"
		+"<td>${fld:created@yyyy-MM-dd HH:mm}</td><td class='max-w-280'>${fld:fbremark@js}</td>"
		+"<td>"+updatedate+"</td><td><button onclick=feedbackdeal('${fld:tuid}') class='my-btn-default-2 "+fkclass+"' style='padding: 8px 0px'>"+btnname+"</button></td></tr>";
</feedback-rows>
$("#nofeedbackcount").html(nofeedbackcount);
$("#feedback").html(str);

//客诉处理
function feedbackdeal(tuid){
	var url="${def:context}${def:actionroot}/deal?tuid="+tuid;
	ajaxCall(url,{
		method:"get",
		progress:true,
		dataType:"script",
		success:function(){	
		}
	});
}



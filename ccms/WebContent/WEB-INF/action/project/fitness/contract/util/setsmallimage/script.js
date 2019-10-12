$("#tdPic").empty();
$("#tdPic").append('<img id="smallPic" code="${fld:upload_id}" style="width:45px;height:50px;" src="${def:context}/action/ccms/attachment/download?id=${fld:upload_id}&&type=1">');
$("#tdPic").find("#smallPic").unbind().on("click",function(){
	var uri = "${def:context}${def:actionroot}/setsmallimage/preview?upload_id=" + $(this).attr("code");
	ccms.dialog.open({url : uri});
});
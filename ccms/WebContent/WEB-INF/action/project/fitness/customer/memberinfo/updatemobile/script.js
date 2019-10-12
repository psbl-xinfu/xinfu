var userid="${fld:user_id}";
var login="${fld:userlogin}";
var url="${def:context}${def:actionroot}/resetpwd?user_id="+userid+"&userlogin="+login+"&passwd=123456";
posturl(url);
function posturl(url){
	ajaxCall(url,{
		method:"post",
		form:"searchForm",
		progress:true,
		dataType:"script",
		success:function(){
			ccms.dialog.alert("修改成功！")
	   		$('#modalAddnew1').modal('hide');
	   		ccms.util.clearForm('addForm');
	   		search.searchData(1);
	   		$('#modalAddnew1').prop('scrollTop','0');
		}
	});
}
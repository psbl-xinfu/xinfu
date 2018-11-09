ccms.dialog.notice("报名成功！",1000,function(){
	location.href="${def:context}/action/project/fitness/wx/market/index/crud?customercode="+$('#customercode').val();
});
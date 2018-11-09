	ccms.dialog.notice("修改成功！",1000,function(){
		location.href="${def:context}/action/project/fitness/wx/cust/center/crud?customercode="+$('#customercode').val();
	});

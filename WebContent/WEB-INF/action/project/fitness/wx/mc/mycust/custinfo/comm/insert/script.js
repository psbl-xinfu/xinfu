ccms.dialog.notice("跟进成功！",1000,function(){
	location.href="${def:context}/action/project/fitness/wx/mc/mycust/custinfo/crud?customercode="+$('#customercode').val();
});
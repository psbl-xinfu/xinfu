ccms.dialog.notice("跟进成功！",1000,function(){
	location.href="${def:context}/action/project/fitness/wx/pt/myziyuan/sijiaoziyuanmsg?customercode="+$('#customercode').val();
});
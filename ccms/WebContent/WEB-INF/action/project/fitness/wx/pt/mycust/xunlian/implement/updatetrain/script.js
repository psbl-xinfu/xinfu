ccms.dialog.notice("执行成功！",1000,function(){
	location.href="${def:context}/action/project/fitness/wx/pt/mycust/sijiaohuiyuanmsg?customercode="+$('#custcode').val()+"&type=pt";
});
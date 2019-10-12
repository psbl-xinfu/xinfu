ccms.dialog.notice("添加成功！",1000,function(){
	location.href="${def:context}/action/project/fitness/wx/pt/mycust/sijiaohuiyuanmsg/?customercode="+$('#customercode').val()+"&type=pt";
});
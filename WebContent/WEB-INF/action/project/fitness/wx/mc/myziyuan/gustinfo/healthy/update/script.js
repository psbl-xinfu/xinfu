ccms.dialog.notice("修改成功！",1000,function(){
	if($('#guestcode').val()==""){
		
		if($('#type').val()=="cust"){
			location.href="${def:context}/action/project/fitness/wx/cust/center/tice/crud?customercode="+$('#customercode').val()+"&type="+$('#type').val();
		}else{
			location.href="${def:context}/action/project/fitness/wx/mc/mycust/custinfo/crud?customercode="+$('#customercode').val()+"&type="+$('#type').val();
		}
	}else{
		location.href="${def:context}/action/project/fitness/wx/mc/myziyuan/gustinfo/crud?guestcode="+$('#guestcode').val()+"&type="+$('#type').val();
	}
});
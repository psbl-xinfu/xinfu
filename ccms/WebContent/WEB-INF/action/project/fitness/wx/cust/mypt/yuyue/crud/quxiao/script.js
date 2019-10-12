ccms.dialog.notice("取消成功！",1000,function(){
	$('#vc_pt').html('');
	$('#pdates').html('');
	$('.hasNone').show();
	$('.yuyue').remove();
	getyuyue($('#pdate').val());
});
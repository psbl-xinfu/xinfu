alert('提交成功！');
var term_score_id=$('.term_score_id').val();
$('.term_submit_btn').remove();
$('input').attr('disabled','true');
$('textarea').attr('disabled','true');
var url = "${def:context}/action/project/fitness/trains/task/detail/term/updatepage"; //更新父页面测评分数
ajaxCall(url,{
		method: "get",
		progress: false,
		dataType: "script",
		success: function(){
		}
});





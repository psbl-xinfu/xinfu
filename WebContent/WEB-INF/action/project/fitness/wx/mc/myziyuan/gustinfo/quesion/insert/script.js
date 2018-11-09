var term_score =  $("#term_score").val();
ccms.dialog.notice("保存成功！");
$('#termResult').val("评估结果："+term_score+"分").append("&nbsp;&nbsp;")
$('#rs').show();
$("html,body").animate({scrollTop:0},200); 
var score=0;
<type>    
var id="${fld:list_id}"
	score="${fld:term_score}"
$('input[value="'+id+'"]').iCheck('check');
if("${fld:list_text}"!=""){
	
	$('input[value="'+id+'"]').parent().parent().parent().next('div').show();
	$('input[value="'+id+'"]').parent().parent().parent().next('div').children('p').children('input').val("${fld:list_text}");
}
 </type>
 $('#termResult').val("评估结果："+score+"分").append("&nbsp;&nbsp;")
 $('#rs').show();
 $('#save').hide();
	
	
	

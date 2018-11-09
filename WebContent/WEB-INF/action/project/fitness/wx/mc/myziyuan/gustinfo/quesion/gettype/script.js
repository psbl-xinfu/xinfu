var str=""
<type>     
	str+='<div class="listother type" code="${fld:type_id}" code1="${fld:tags}"  code2="${fld:item_num}" >'
	str+='             <p class="p3"style="font-weight: bold;">${fld:type_name}</p>'
	str+='     </div>'
  </type>
	
$('.myziyuangenjincontent').html(str)

$('.type').each(function(){
	var typeid=$(this).attr('code');
	var tag=$(this).attr('code1');
	var item_num=$(this).attr('code2');
	getQuestion(typeid,tag,item_num);
})


getAnswer();

function getQuestion(typeid,tag,item_num){
	getAjaxCall("/action/project/fitness/wx/mc/myziyuan/gustinfo/quesion/getquestion?type_id="+typeid
			+"&question_bank_id="+$('#question_bank_id').val()
			+"&item_num="+item_num
			+"&tag="+tag,
			false);
}
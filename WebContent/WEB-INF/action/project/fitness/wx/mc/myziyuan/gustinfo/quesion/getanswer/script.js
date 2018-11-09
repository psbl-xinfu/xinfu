<type>    
	var str=""
	var type="${fld:item_id}";
	 if("${fld:parent_type}"==1){
			if("${fld:show_type}"==0){
					str+='   <div class="listother" >'
					str+=' <p class="p1"><input    question="${fld:item_id}"  answeridscore="${fld:list_score}" class="radio"  type="radio"  name="result${fld:item_id}" value="${fld:tuid}">${fld:list_name}</p>'
					str+='</div>'
			}else if("${fld:show_type}"==2){
					str+='   <div class="listother" >'
					str+=' <p class="p1" ><input  show_type="2"    question="${fld:item_id}"  answeridscore="${fld:list_score}" class="radio input"  type="radio"  name="result${fld:item_id}" value="${fld:tuid}">${fld:list_name}</p>'
					str+='</div>'
				
					str+='   <div class="listother" >'
					str+='     <p class="p2" ><input type="text"  id="" name=""  class="textinput"  value="" placeholder="请输入"></p>'
					str+='</div>'
			}
		}else{
			str+=' <p class="p1"><input    question="${fld:item_id}"  answeridscore="${fld:list_score}" class="checkbox"  type="checkbox"  name="result${fld:item_id}" value="${fld:tuid}">${fld:list_name}</p>'
		}
	$('.listother[question="'+type+'"]').after(str);
  </type>
	renderRadioObj(".radio");
	renderCheckboxObj(".checkbox");
	
	$('.p2').parent().hide();
	
	$(".input").each(function(){
		$(this).on('ifClicked',function(){
			$('.p2').parent().hide();
			$(this).parent().parent().parent().next('div').show()
		})
	})
	
		if($('#tuid').val()!=""){
			getResult($('#tuid').val());
		}
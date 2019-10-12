var str=""
var type=""
var len=0
<type>    
len++;
	type="${fld:type_id}";
	str+='   <div class="listother question" question="${fld:item_id}" typeid="${fld:type_id}" >'
	str+='<p class="p3">'+len+'&nbsp;${fld:item_name}</p>'
	str+='</div>'
  </type>
	$('.listother[code="'+type+'"]').after(str);
	
	
	
	

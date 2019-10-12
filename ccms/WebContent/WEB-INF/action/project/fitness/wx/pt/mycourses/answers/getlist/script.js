var str="<div class='answers'>"
var id=""
<list>
id="${fld:tuid}";
if("${fld:question_type}"==0){
	str+='<li><input type="radio" class="radio"  name="result${fld:tuid}"  tuid="${fld:tid}"  score="${fld:item_score}">${fld:item_name}</li>'
}else{
	str+='<li><input type="checkbox" class="checkbox"  name="result${fld:tuid}"    tuid="${fld:tid}"     score="${fld:item_score}">${fld:item_name}</li>'
}
</list>
str+='</div>';
$('.querstiondiv[code="'+id+'"]').after(str);
renderRadioObj(".radio");
renderCheckboxObj(".checkbox");
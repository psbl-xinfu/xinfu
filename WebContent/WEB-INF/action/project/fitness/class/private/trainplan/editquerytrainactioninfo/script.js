var num=$('article').length+1;
var htmlstr = "<article><button class='delete' onclick='deletedetail(this)'></button>"
	+"<header>动作"+num+"</header><ul class='pup-ul'><li>"
	+"<span  style='width:80px'>训练部位：</span><div class='my-selected input-long'>"
	+"<select class='normal-select' id='trainingsite${fld:code}' placeholder='请选择训练部位' name='trainingsite'><option value=''>请选择</option>";

<ts-rows>
	htmlstr+="<option value='${fld:domain_value}'>${fld:domain_text_cn}</option>";
</ts-rows>
	htmlstr+="</select></div></li><li><span style='width:120px'>器械：</span><div class='my-selected input-long'>"		
			+"<select class='normal-select' id='largecategories${fld:code}' placeholder='请选择类别' name='largecategories' onchange='large(this)'><option value=''>请选择</option>";
<lc-rows>
	htmlstr+="<option value='${fld:domain_value}'>${fld:domain_text_cn}</option>";
</lc-rows>
	htmlstr+="</select></div></li><li><span  style='width:80px'>动作：</span><div class='my-selected input-long'>"
		+"<select class='normal-select' placeholder='请选择动作' name='action' onchange='actionchange(this)' id='action${fld:code}'>"
			+"<option value=''>请选择</option></select></div></li><li>"
			+"<span  style='width:120px'>训练细节部位：</span>"
			+"<input  type='text' name='details' id='details${fld:code}' readonly='readonly' style='background: #363d4c;width:160px'  /></li>"
			+"<li><span>组：</span>"	
			+"<input class='input-short' id='group${fld:code}' type='text' name='group'></li>"
			+"<li><span>重量：</span>"
			+"<input class='input-short' type='text' name='heavynum' id='heavynum${fld:code}'></li>"
			+"<li><span>数量：</span>"
			+"<input class='input-short' type='text' name='num' id='num${fld:code}'></li>"
			+"<li><span style='width:80px'>学员感觉：</span><div class='my-selected input-short' style='width:60px'>"	
			+"<select class='normal-select' placeholder='请选择' name='sense' id='sense${fld:code}'>";
<stu-rows>
	htmlstr+="<option value='${fld:domain_value}'>${fld:domain_text_cn}</option>";
</stu-rows>
	htmlstr+="</select></div></li></ul></article>";
$("#trainplandetail").append(htmlstr);
searchSelectInit($("select[name=trainingsite],select[name=largecategories],select[name=action],select[name=sense]"));

function deletedetail(del){
	$(del).parent().prev().remove();
	$(del).parent().remove();
}
$("#trainingsite${fld:code}").val("${fld:train_part}");
$("#largecategories${fld:code}").val("${fld:apparatus}");
$("#details${fld:code}").val("${fld:train_detail_part}");
$("#group${fld:code}").val("${fld:groups}");
$("#heavynum${fld:code}").val("${fld:weight}");
$("#num${fld:code}").val("${fld:num}");
$("#sense${fld:code}").val("${fld:custfeel}");
var url = "${def:context}${def:actionroot}/querytrainaction?largecategories=${fld:apparatus}&trainingsite=${fld:train_part}";
//查询动作
getJsonAjaxCall(url, true, function(data){
	var actionhtml = "<option value=''>请选择</option>";
	for(var i=0;i<data.length;i++){
		if(data[i].code!=undefined)
			actionhtml += "<option value='"+data[i].code+"'>"+data[i].actions+"</option>";
	}
	$("#action${fld:code}").html(actionhtml);
	$("#action${fld:code}").val("${fld:actionscode}");
});
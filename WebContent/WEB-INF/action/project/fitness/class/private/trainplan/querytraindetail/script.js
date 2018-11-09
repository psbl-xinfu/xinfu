var num=$('article').length+1;

var htmlstr='<article>'
	 htmlstr+='<button class="delete" onclick="deletedetail(this)"></button>'
	 htmlstr+='<header>动作'+num+'</header>'
	  htmlstr+=	'<ul class="pup-ul">'
		  
	  htmlstr+='<li>'
	  htmlstr+=	'<span  style="width:80px">训练部位：</span>'
	  htmlstr+=	'<div class="my-selected input-long">'
	  htmlstr+=	'<select  placeholder="请选择训练部位" name="trainingsite" style="display: none;">'
	  htmlstr+=	'<option value="">请选择</option>'
				<ts-rows>
					htmlstr+='<option value="${fld:domain_value}">${fld:domain_text_cn}</option>'
				</ts-rows> 
	  htmlstr+=	'</select>'
	  htmlstr+=	'</div>'
	  htmlstr+=	'</li>'
		  
	  htmlstr+='<li>'
      htmlstr+='<span  style="width:120px">器械：</span>'
	  htmlstr+='<div class="my-selected input-long">'
	  htmlstr+='<select  placeholder="请选择类别" name="largecategories" onchange="large(this)" style="display: none;">'
	  htmlstr+='<option value="">请选择</option>'
			  <lc-rows>
						htmlstr+='<option value="${fld:domain_value}">${fld:domain_text_cn}</option>';
				</lc-rows>
	  htmlstr+='</select>'
	  htmlstr+='</div>'
	  htmlstr+='</li>'
							
  	  htmlstr+='<li>'
      htmlstr+='<span  style="width:80px">动作：</span>'
	  htmlstr+='<div class="my-selected input-long">'
	  htmlstr+='<select  placeholder="请选择动作" name="action" onchange="actionchange(this)" style="display: none;">'
	  htmlstr+='<option value="">请选择</option>'
	  htmlstr+='</select>'
	  htmlstr+='</div>'
	  htmlstr+='</li>'					
							
  	  htmlstr+='<li >'
      htmlstr+='<span  style="width:120px">训练细节部位：</span>'
      htmlstr	+="<input  type='text' name='details' readonly='readonly' style='background: #363d4c;width:160px'  />"
	  htmlstr+='</li>'			  
		  
		htmlstr+='<li >'
		htmlstr+='<span>组：</span>'
		htmlstr+='<input class="input-short" type="text" name="group">'
		htmlstr+='</li>'
		
 		htmlstr+='<li>'
		htmlstr+='<span>重量：</span>'
		htmlstr+='<input class="input-short" type="text" name="heavynum">'
		htmlstr+='</li>'
			
		htmlstr+='<li>'
		htmlstr+='<span>数量：</span>'
		htmlstr+='<input class="input-short" type="text" name="num">'
		htmlstr+='</li>'			
			
	  htmlstr+='<li>'
      htmlstr+='<span style="width:80px">学员感觉：</span>'
      htmlstr+='<div class="my-selected input-short" style="width:60px">'
	  htmlstr+='<select  placeholder="请选择" name="sense" style="display: none;">'
		  htmlstr+='<option value="">请选择</option>'
		  <stu-rows>
	  			htmlstr+='<option value="${fld:domain_value}">${fld:domain_text_cn}</option>';
		</stu-rows>
	  htmlstr+='</select>';
	  htmlstr+='</div>';
	  htmlstr+='</li>';
	  htmlstr+='</ul>';
	  htmlstr+='</article>';

$("#trainplandetail").append(htmlstr);
searchSelectInit($("select[name=trainingsite],select[name=largecategories],select[name=action],select[name=sense]"));

function deletedetail(del){
	$(del).parent().remove();
}
//器械事件
function large(val){
	var lc = $(val).val();
	if(lc==""){
		$(val).parent().parent().parent().find("[name=action]").html("");
		$(val).parent().parent().parent().find("[name=details]").val("");
		return false;
	}
	var trainingsite = $(val).parent().parent().parent().parent().find("[name=trainingsite] option:selected").val();
	if(trainingsite==""){
		ccms.dialog.alert('请选择训练部位！');
		return false;
	}
	var url = "${def:context}${def:actionroot}/querytrainaction?largecategories="+lc
		+"&trainingsite="+trainingsite;

	//查询动作
	getJsonAjaxCall(url, true, function(data){
		var actionhtml = "<option value=''>请选择</option>";
		for(var i=0;i<data.length;i++){
			if(data[i].code!=undefined)
				actionhtml += "<option value='"+data[i].code+"'>"+data[i].actions+"</option>";
		}
		$(val).parent().parent().parent().parent().find("[name=action]").html(actionhtml);
		$("[name=action]").selectpicker("refresh");
		$("[name=action]").selectpicker("render");
	});
}
//动作事件
function actionchange(val){
	var action = $(val).val();
	if(action==""){
		$(val).parent().parent().parent().find("[name=details]").val("");
		return false;
	}
	var url = "${def:context}${def:actionroot}/querytrainactioninfo?code="+action;
	//查询动作
	getJsonAjaxCall(url, true, function(data){
		for(var i=0;i<data.length;i++){
			if(data[i].train_detail_part!=undefined)
				$(val).parent().parent().parent().parent().find("[name=details]").val(data[i].train_detail_part);
		}
	});
}

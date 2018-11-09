var str="";	

str+='<select name="trainingsite" id="trainingsite" onchange="clearn()">'
	<ts-rows>
		str+='	<option value="${fld:domain_value}">${fld:domain_text_cn}</option>'
	</ts-rows>
str+='	</select>'
	
str+='<select  name="largecategories" onchange="large(this)">'
	str+='<option value="">请选择</option>'
	<lc-rows>
		str+='	<option value="${fld:domain_value}">${fld:domain_text_cn}</option>'
	</lc-rows>
str+='	</select>'

str+='<select name="action" onchange="actionchange(this)">'
str+='	<option value="">动作</option>'
str+='</select>'
$('.content').children('.header').html(str);



function deleteDiv(obj){
	$(obj).parent().parent().remove();
}
function show(obj){
	$(obj).parent().parent().find('.isshow').slideDown('1000');
}
function hide(obj){
	$(obj).parent().parent().find('.isshow').slideUp('1000');
}
//器械事件
function large(val){
	var lc = $(val).val();
	if(lc==""){
		$(val).parent().parent().find("[name=action]").html("");
		$('.brief').text('细节：');
		return false;
	}
	var trainingsite = $(val).parent().parent().find("[name=trainingsite] option:selected").val();
	if(trainingsite==""){
		ccms.dialog.notice('请选择训练部位！');
		return false;
	}
	var url = "${def:context}${def:actionroot}/querytrainaction?largecategories="+lc
		+"&trainingsite="+trainingsite;

	//查询动作
	getJsonAjaxCall(url, true, function(data){
		var actionhtml = "<option value=''>--请选择--</option>";
		for(var i=0;i<data.length;i++){
			if(data[i].code!=undefined)
				actionhtml += "<option value='"+data[i].code+"'>"+data[i].actions+"</option>";
		}
		$(val).parent().parent().find("[name=action]").html(actionhtml);
		if($('#inaction').val()!=""){
			$("select[name=action]").val($('#inaction').val());
		}
	});
}
//动作事件
function actionchange(val){
	var action = $(val).val();
	if(action==""){
		$('.brief').text('细节：');
		return false;
	}
	var url = "${def:context}${def:actionroot}/querytrainactioninfo?code="+action;
	//查询动作
	getJsonAjaxCall(url, true, function(data){
		for(var i=0;i<data.length;i++){
			if(data[i].train_detail_part!=undefined)
				var xijie=data[i].train_detail_part;
				$('.brief').text("细节："+xijie);
		}
	});
}

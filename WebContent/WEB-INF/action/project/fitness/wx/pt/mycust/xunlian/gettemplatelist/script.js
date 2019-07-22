var trainplanstatus="";
var index=0;
var str="";
$('#template').html('');
$('#warmup_mins').val("");
$('#aerobic_mins').val("");
$('#run_mileage').val("");

<list>
index++;
if(index==1){
	$('#warmup_mins').val("${fld:warmup_mins}");
	$('#aerobic_mins').val("${fld:aerobic_mins}");
	$('#run_mileage').val("${fld:run_mileage}");
	trainplanstatus="${fld:status}";
}
addTemPlate("${fld:train_part}","${fld:apparatus}","${fld:actioncode3}","${fld:train_detail_part}",index,"${fld:code}","${fld:group}","${fld:num}","${fld:weight}",
"${fld:actioncode1}","${fld:actioncode2}","${fld:actioncode3}"
);
</list>

function addTemPlate(action1,action2,action3,action4,index,code,group,num,weight,actioncode1,actioncode2,actioncode3){
	str+='<div class="con-3" id="list'+code+'"  code="'+code+'">'
	str+='<div class="title">训练计划'+index
	str+='<span class="fr btn-remove"onclick="deleteAction('+code+')">删除</span>'
	/*str+='<span class="fr btn-update" onclick="actionDivShow('+code+')">修改</span>'*/
	str+='</div>'
	str+='<div class="con-type"  code1="'+actioncode1+'"  code2="'+actioncode2+'"  code3="'+actioncode3+'">'
	str+='<span>部位：'+action1+'</span>'
	str+='<span >器械：'+action2+'</span>'
	str+='<span >动作：'+action3+'</span>'
	str+='<span >细节：'+action4+'</span>'
	str+='</div>'
	str+='<div class="con-details">'
	str+='<div class="d-form clearlr">'
	str+='<div class="d-d">'
	str+='<span>分组：'+group+'</span>'
	str+='<span>最大数量：'+num+'</span>'
	str+='<span>最大重量：'+weight+'</span>'
	str+='</div>'
	str+='<div class="btn clearlr">'
	str+='<span class="btn-open"code="'+code+'"></span>'
	str+='<span class="btn-close disNone"  code="'+code+'"></span>'
	str+='</div>'
	str+='</div>'
	str+='</div>'
	str+='</div> '
		
		//组列表
		str+='<div class="con-4">'
		str+='<div class="con-details clearlr">'
		
		str+='<div class="con-d" style="display:none;margin-left:-10px">'
			str+='<span class="title"></span>'
			str+='<div class="d-d">'
				str+='<span >分组：</span>'
				str+='<span>最大数量：</span>'
				str+='<span>最大重量：</span>'
			str+='</div>'
		str+='</div>'
			
			
		str+='<div class="con-d-1">'
		str+='</div>'
		str+='</div>'
		str+='</div>'
}
$('#template').html(str);

	<detail>
	var len=$("#list"+"${fld:detailcode}").next('div').find('.con-d-1').find('.con-group').length;
	len++;
		var str2="";
		str2+='<div class="con-group" id="con-group${fld:pcode}" >'
		str2+='<div class="group-title">'
		str2+='<span class="num">第'+len+'组：</span>'
		str2+='<span class="fr btn-remove" onclick="deleteGroup(${fld:pcode})"></span>'
		str2+='<span class="fr btn-save" onclick="updateGroup(${fld:pcode})"></span>'
		str2+='</div>'
		str2+='<div class="group-con clearlr" id="group${fld:pcode}" code="${fld:pcode}">'
		str2+='<div class="g-d"><label>数量：</label><input type="text" name="num" value=""></div>'
		str2+='<div class="g-d"><label>重量：</label><input type="text" name="weight" value=""></div>'
		str2+='<div class="g-d"><label>感觉：</label>'
		str2+='<select name="custfeel" style="width:70px">'
		str2+=status
		str2+='</select></div>'
		str2+='</div>'
		str2+='</div>'
		$("#list"+"${fld:detailcode}").next('div').find('.con-d-1').append(str2);
		$('#group${fld:pcode}').find('input:eq(0)').val("${fld:num}");
		$('#group${fld:pcode}').find('input:eq(1)').val("${fld:weight}");
		$('#group${fld:pcode}').find('select:eq(0)').val("${fld:custfeel}");
	</detail>
	 showBind();
	
	 
	 
	<history>
		var obj=$('.con-type[code1=${fld:train_part}][code2=${fld:apparatus}][code3=${fld:actionscode}]').parent().next('div').find('.con-d')
		if($(obj).length!=0){
			$(obj).each(function(){
				$(this).show();
				$(this).find('.title').text('历史记录：${fld:created}');
				$(this).children('div').children('span').eq(0).text("分组：${fld:group}");
				$(this).children('div').children('span').eq(1).text("最大数量：${fld:num}");
				$(this).children('div').children('span').eq(2).text("最大重量：${fld:weight}");
			})
			
		}
	</history>
	
	if(trainplanstatus==2||$('#ptpreparecode_record').val()!==""){
		 $('.btn-remove,.btn-save,.btn-add').hide();
		 $('input').attr('disabled',true);
		 $('select').attr('disabled',true);
	}else{
		 $('.btn-remove,.btn-save,.btn-add').show();
	}

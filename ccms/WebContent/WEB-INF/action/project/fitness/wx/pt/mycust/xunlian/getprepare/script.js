var str="";
var flag=true
<list>
flag=false;
str+='<li  code="${fld:code}"   onclick="huixian(\'${fld:pdcode}\',\'${fld:code}\',\'${fld:ptlevelname}\',\'${fld:times}\',\'${fld:traincode}\',\'${fld:status}\')">'
str+='<span>${fld:preparetime}</span>'
str+='<span style="margin-left:10%">${fld:ptlevelname}</span>'
if("${fld:status}"==2){
	str+='<span style="margin-left:10%">已执行</span>'
}else{
	str+='<span style="margin-left:10%">未执行</span>'
}
str+='</li>'
</list>
if(flag){
	$('#datas').html('<p style="margin-left:41.5%">暂无预约</p>');
}else{
	$('#datas').html(str);
}


if($('#ptpreparecode_record').val()!==""){
	var code=$('#ptpreparecode_record').val();
	$('#datas').find('li[code='+code+']').click();
}


function huixian(pdcode,code,ptlevelname,times,traincode,status){
	$('#pdcode').val(pdcode);
	$('#ptpreparecode').val(code);
	$('.course').text("课程:"+ptlevelname);
	$('.duration').text("时长："+times+"min");
	$('#traincode').val(traincode);
	$("#custlist").addClass('disNone');
	if(traincode!=""&&traincode!=null){
		gettemplatelist();
	}else{
		$('#template').html('');
	}
	
	if(status==2||$('#ptpreparecode_record').val()!==""){//已执行
		 $('button').hide();
	}else{
		 $('button').show();
	}
	
}
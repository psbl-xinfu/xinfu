var str="";
var flag=true;
<rows>
var flag=false;
var status="${fld:ss}";
if(status=="已开始"){
	str+='<li class="yellow" style="margin-top:10px;">';
}else if(status=="已结束"){
	str+='<li style="margin-top:10px;">';
}else if(status=="预约中"){
	str+='<li class="type1"style="margin-top:10px">';
}
str+='<div  code="${fld:cdcode}" code1="${fld:ss}" code2="${fld:code}"  code3="${fld:isyuyue}" onclick="getInfo(this)">';
str+='	<h3>';
str+='		<p>${fld:class_name}</p>';
str+='		<p>';
	if(status!="预约中"){
		str+='			已预约<span>${fld:nowcount}</span>人/可预约<span>${fld:limitcount}</span>人';
	}else{
		var zong ="${fld:limitcount}";
		var now="${fld:nowcount}";
			  now=zong-now;
		str+='			缺<span> '+now+'</span>人开课/${fld:isyuyue}';
	}
str+='		</p>';
str+='	</h3>';
str+='	<p>';
str+='		<span>${fld:times}分钟</span>';
str+='		<span>${fld:name@js}教练</span>';
str+='		<span>${fld:classroom_name@js}</span>';
str+='	</p>';
str+='</div>';
str+='<p style="margin-left:4%;">';
str+='	<span>${fld:classtime}</span>';
str+='	<span  class="yuyue" style="width:60px;text-align:center" >'+status+'</span>';
str+='</p>';
str+='</li>';
</rows>
if(!flag){
	$('.left').html(str);
}else{
	$('.left').html('<span style="margin-left:20%">暂无课程</span>');
}

function getInfo(obj){
	var dcode=$(obj).attr('code');
	var ccode=$(obj).attr('code2');
	var status=$(obj).attr('code1');
	var isyuyue=$(obj).attr('code3');
	
	$('#dcode').val(dcode);
	$('#ccode').val(ccode);
	$('#status').val(status);
	$('#isyuyue').val(isyuyue);
	$('form').submit();
}

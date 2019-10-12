<rows>
var str="";
	var time;
	var time2="${fld:preparetime}".substring(3,5)
	var time3="";
	var flag=false;
	
	if(time2!='00'||time2!='30'){
		flag=true;
		time="${fld:preparetime}".substring(0,3)
		time3="${fld:preparetime}";
		if(Number(time2)>0&&Number(time2)<=59){
			time2='00'
		}
		time=time+time2
	}else{
		time="${fld:preparetime}".substring("${fld:preparetime}",5)
	}

var printime=time.substring(0,3)
printime+="00"	

//长度修改
var pt="${fld:pt}";
	if(pt.length>4){
		pt=pt.substring(0,4);
		pt+='...'
	}
	
var classname="${fld:classname}";
	if(classname.length>7){
		classname=classname.substring(0,7);
		classname+='...'
	}
if($('.yuyue').find('div[code=preparelist][code1="'+ printime+'"]').length > 0 ){
	if("${fld:status}"=="待确认"){
		str+='<div  class="yellow1"  onclick="yuyueinfo(\'${fld:code}\')">'
	}else{
		str+='<div   class="r-black1"   onclick="yuyueinfo(\'${fld:code}\')">'
	}	
	str+='<p > <span style="font-weight:bold;display:inline-block;width:100px">'+pt+'</span><span  style="display:inline-block">'+classname+'</span></p>'
	str+='			<p>'
		if(flag){
			str+='			<span>'+time3+'-${fld:preparetime1}</span>';
		}else{
			str+='			<span>'+time+'-${fld:preparetime1}</span>';
		}	
	str+='			<span style="margin-left:8px">${fld:status}</span>'
	str+='		</p>'
	str+='		<p >'
	str+='		</p>'
	str+='</div>';
	
	var obj=$('.yuyue').find('div[code=preparelist][code1="'+ printime+'"]')
	obj.append(str);
}else{
	var printime=time.substring(0,3)
	printime+="00"
	str+='<li class="yuyue moreDiv">'
		str+='<div code="preparelist"  class="mm" code1="'+ printime+'">'
			
			
		if("${fld:status}"=="待确认"){
			str+='<div  class="yellow1"  onclick="yuyueinfo(\'${fld:code}\')">'
		}else{
			str+='<div   class="r-black1"   onclick="yuyueinfo(\'${fld:code}\')">'
		}	

	str+='<p > <span style="font-weight:bold;display:inline-block;width:100px">'+pt+'</span><span  style="display:inline-block">'+classname+'</span></p>'
		str+='			<p>'
			
		if(flag){
			str+='			<span>'+time3+'-${fld:preparetime1}</span>';
		}else{
			str+='			<span>'+time+'-${fld:preparetime1}</span>';
		}	

		str+='			<span style="margin-left:8px">${fld:status}</span>'
		str+='		</p>'
		str+='		<p >'
		str+='		</p>'
		str+='</div>'

		str+='</div>'
		str+='</li>'
		$('.hasNone img[code="'+ time+'"]').parent().hide();
		$('.hasNone img[code="'+ time+'"]').parent().next().hide();
		$('.hasNone img[code="'+ time+'"]').parent().next().after(str);
}
	


</rows>

	
$('.hasNone img').each(function(){
	$(this).on('click',function(){
		var time=$(this).attr('code');
		var moon=$('.active').children('span').text();
		moon=moon.replace('/','-');
		var parpreYear=d.getFullYear();
		parpreYear=parpreYear+'-'+moon
		addyuyue(parpreYear,time);
	})
})


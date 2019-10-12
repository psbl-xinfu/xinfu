<rows>
var str=""	
var time;
var time2="${fld:preparetime}".substring(3,5)
var time3="";
var flag=false;

if(time2!='00'||time2!='30'){
	flag=true;
	time="${fld:preparetime}".substring(0,3)
	time3="${fld:preparetime}";
	if(Number(time2)>0&&Number(time2)<=59){
		time2='00';
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
		str+='<div  class="yellow1  bind" code="0">'
	}else{
		str+='<div   class="r-black1 bind"   code="1">'
	}	

	
	str+='<p > <span style="font-weight:bold;display:inline-block;width:100px">'+pt+'</span><span  style="display:inline-block">'+classname+'</span></p>'
	str+='			<p>'
		
	if(flag){
		str+='			<span>'+time3+'-${fld:preparetime1}</span>';
	}else{
		str+='			<span>'+time+'-${fld:preparetime1}</span>';
	}	

	str+='			<span style="margin-left:2px">${fld:status}</span>'
	str+='		</p>'
	str+='		<p class="hide" style="display:none;">'
	str+='			<span  onclick="quxiao(${fld:code})"  >取消预约</span>'
	str+='			<span  onclick="biangeng(${fld:code})"  >变更时间</span>'
	str+='		</p>'
	str+='</div>'
		var obj=$('.yuyue').find('div[code=preparelist][code1="'+ printime+'"]')
		obj.append(str);
}else{
str+='<li class="yuyue moreDiv ">'
var printime=time.substring(0,3)
printime+="00"
str+='<div code="preparelist"  class="mm" code1="'+ printime+'">'

if("${fld:status}"=="待确认"){
	str+='<div  class="yellow1  bind" code="0">'
}else{
	str+='<div   class="r-black1 bind"   code="1">'
}	

str+='<p > <span style="font-weight:bold;display:inline-block;width:100px">'+pt+'</span><span  style="display:inline-block">'+classname+'</span></p>'



str+='	<p>'
	
if(flag){
	str+='			<span>'+time3+'-${fld:preparetime1}</span>';
}else{
	str+='			<span>'+time+'-${fld:preparetime1}</span>';
}	

str+='			<span style="margin-left:2px">${fld:status}</span>'
str+='		</p>'
str+='		<p class="hide" style="display:none;">'
str+='			<span  onclick="quxiao(${fld:code})"  >取消预约</span>'
str+='			<span  onclick="biangeng(${fld:code})"  >变更时间</span>'
str+='		</p>'
str+='</div>'
	
str+='</div>'
str+='</li>'
	
$('.hasNone img[code="'+ time+'"]').parent().hide();
$('.hasNone img[code="'+ time+'"]').parent().next().hide();
$('.hasNone img[code="'+ time+'"]').parent().next().after(str)
}
</rows>

var timeOutEvent=0;
$(".bind").each(function(){
	var obj=$(this).find('.hide');
	$(this).on('click',function(){
		if($(this).attr('code')==1){
			 ccms.dialog.notice("已确认课程无法修改，请联系教练！");
		}else{
			$('.hide').hide();
			$(obj).show();
		}
	})
	
/*	$(this).on({
		touchstart: function(e){
			timeOutEvent = setTimeout(function(){
				$(obj).show();
				timeOutEvent = 0; 
			},500);
		 	e.preventDefault();
		},
		touchmove: function(){
            	clearTimeout(timeOutEvent); 
		    	timeOutEvent = 0; 
		},
		touchend: function(){
	   		clearTimeout(timeOutEvent);
			if(timeOutEvent!=0){ 
				//quxiao(code);
			} 
		}
	})*/
})

/*$(".biangeng").each(function(){
	
})*/



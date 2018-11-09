var str2="";
var courseid="";
var index=0
<list>
	index++;
	var min=secToMin("${fld:timelength}");
	courseid="${fld:courseid}";
	str2+='<li  code="${fld:status}" time="${fld:currentsecond}" onclick="bofang(this,\'${fld:videourl}\',\'${fld:courseid}\',\'${fld:classid}\',\'${fld:course_skill_id}\',\'${fld:skill_id}\',\'${fld:currentsecond}\')">'
	
	var time=secToMin("${fld:currentsecond}");
		
	str2+='<label class="sch-title">第'+index+'节：${fld:class_name}</label>'
	str2+='<label class="total-time">时长：'+min+'</label>'
	
	if("${fld:status}"==""||"${fld:status}"==null){
		str2+='<label class="study-time">未开始</label>'
	}else if("${fld:status}"==2){
		str2+='<label class="study-time">已学完</label>'
	}else{
		str2+='<label class="study-time">已学习：'+time+'</label>'
	}
	str2+='<span class="btn-video">视频</span>'
	str2+='</li>'
</list>
	$('ul[code="'+courseid+'"]').append(str2);

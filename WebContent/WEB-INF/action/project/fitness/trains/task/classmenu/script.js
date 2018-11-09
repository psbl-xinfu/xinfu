var DETAIL_URL="${def:context}/action/project/fitness/trains/task/detail?courseid=";
function loadClassMenu(courseid,classid,classname,resourceid,coverurl,numone, numtwo) //加载右侧课时列表
{
	var name = classname;
	if(classname.length>8){
		classname = classname.substring(0,8)+"...";
	}
	var statusname = "", finished_status = 0;
	if(numtwo>0){
		statusname = "已学习";
		finished_status = 2;
	}else if(numtwo==0&&numone>0){
		statusname = "学习中";
		finished_status = 1;
	}else{
		statusname = "未学习";
	}
	
	var html="<figure class='video_box' style='display:inline-block;' iframe_src='"+DETAIL_URL+String(courseid)+"&finished_status="+String(finished_status)+"' id='classid_"+String(classid)+"' classcode='"+String(classid)+"' resourceid='"+String(resourceid)+"'>"+
			"<img src='"+coverurl+"' alt='' title='"+name+"' onerror=this.src='${def:context}/js/project/fitness/image/SVG/videocover.png' />"+
			"<figcaption title='"+name+"'>"+classname+"</figcaption>"+
			"<footer>"+
			"<span class='video_info-has_learning state'>"+statusname+"</span>"+
			"<span class='video_info-learning_times times'>"+(numone+numtwo)+"次学习</span>"+
			"</footer>"+
			"</figure>";
	$('#video_list_box').append(html);
}

function loadLearningStatus(classid) //加载课时学习状态
{
	var gray_layout='<div class="gray_layout"></div>';
	var tag_class=$('.video_box#classid_'+String(classid));
	tag_class.find('.video_info-has_learning.state').attr('class','video_info-has_learning active state').text('已学习');
	tag_class.prepend(gray_layout);
}

function loadLearningTimes(classid,times) //加载课时学习次数
{
	var tag_class=$('.video_box#classid_'+String(classid));
	tag_class.find('.video_info-learning_times.times').text(String(times)+'次学习');
}

$('#video_list_box').children().remove();
<class-menu-rows>
    //var finished_status=$('.course_name-li#courseid_'+'${fld:courseid}').attr('finished_status');
	loadClassMenu(${fld:courseid},${fld:classid},'${fld:class_name}',${fld:resourceid},'${fld:coverurl}',${fld:numone},${fld:numtwo});
</class-menu-rows>
	
<class-status-rows>
	loadLearningStatus(${fld:classid});
</class-status-rows>

<learning-times-rows>
 loadLearningTimes(${fld:classid},${fld:times});
</learning-times-rows>


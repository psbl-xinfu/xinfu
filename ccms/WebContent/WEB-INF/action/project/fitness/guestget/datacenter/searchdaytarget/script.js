
var date = new Date("${fld:daydateinfo}");
var year = date.getFullYear();
var month = date.getMonth()+1;
var daynum = new Date(year, month, 0).getDate();


var guest_target = 0, dayguestnum = 0;
<target-rows>
guest_target = Math.ceil(parseInt("${fld:guest_target}")/daynum);
</target-rows>
$("#daytargetnum").html(guest_target);

dayguestnum = ${fld:dayguestnum};
$("#dayguestnum").html(dayguestnum);

if(dayguestnum>0&&parseInt(guest_target)==0){
	$("#daypercentage").html("100");
}else if(dayguestnum==0&&parseInt(guest_target)==0){
	$("#daypercentage").html("0.00");
}else{
	var percentage = Number(dayguestnum/guest_target*100).toFixed(2);
	if(isNaN(percentage)){
		percentage="0.00";
	}
	$("#daypercentage").html(percentage);
}


$("#daylist").html("");
<team-rows>
	var userguestnum = Math.ceil(parseInt(${fld:guest_target})/daynum);
	var guestnum = parseInt(${fld:guestnum});
	if(isNaN(userguestnum)){
		userguestnum = 0;
	}
	var percentage = 0;
	if(guestnum>0&&userguestnum==0){
		percentage = 100;
	}else if(guestnum==0&&userguestnum==0){
		percentage = 0.00;
	}else{
		percentage = Number(guestnum/userguestnum*100).toFixed(2);
	}
	var daylist="<h1 class='gg-task-hd'>${fld:name}<span class='desc-btn' onclick=teamdetail(${fld:pk_value})>详情</span></h1>"
			+"<ul class='gg-task-mid' style='margin-bottom: 0;padding-bottom: 0;'>"
			+"<li><p class='num-wrap'><span class='num'>${fld:usernum}<i style='color: #848999' id='day${fld:pk_value}rate'></i></span></p>"
			+"<p>人员达标率</p><span class='sep'></span></li><li>"
			+"<p class='num-wrap'><span class='num'>${fld:guestnum}</span>个</p>"
			+"<p>获客数量</p><span class='sep'></span></li><li>"
			+"<p class='num-wrap'><span class='num'>"+userguestnum+"</span>个</p>"
			+"<p>任务总量</p></li></ul><ul class='gg-task-ft'>"
			+"<li><span class='label'>任务完成比例</span><div class='progress'>"
			+"<span class='progress-play' id='dayprogress-play${fld:pk_value}'></span></div>"
			+"<span class='percent'>"+percentage+"%</span></li></ul>";
	$("#daylist").append(daylist);
	$("#dayprogress-play${fld:pk_value}").css("width", (percentage>100?100:percentage)+"%");

	var url="${def:actionroot}/daysuccessrate?daydateinfo=${fld:daydateinfo}&team_id=${fld:pk_value}";
	ajaxCall(url,{
		method:"get",
		progress:true,
		dataType:"script",
		success:function(){
		}
	});
</team-rows>
//组详情
function teamdetail(team_id){
    location.href = contextPath+"/action/project/fitness/guestget/grouptask/crud?team_id="+team_id+"&teamtype=1";
}

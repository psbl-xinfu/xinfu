
var count = 0, guest_target = 0, monthguestnum = 0;
<target-rows>
$("#monthtargetnum").html("${fld:guest_target}");
count++;
</target-rows>
if(count==0){
	$("#monthtargetnum").html(0);
}
if($("#monthtargetnum").html()==""){
	guest_target = 0;
}else{
	guest_target = parseInt($("#monthtargetnum").html());
}

$("#monthguestnum").html("${fld:monthguestnum}");
monthguestnum = ${fld:monthguestnum};
if(isNaN(guest_target)){
	guest_target = 0;
}
if(monthguestnum>0&&parseInt(guest_target)==0){
	$("#monthpercentage").html("100");
}else if(monthguestnum==0&&parseInt(guest_target)==0){
	$("#monthpercentage").html("0.00");
}else{
	var percentage = Number(monthguestnum/guest_target*100).toFixed(2);
	if(isNaN(percentage)){
		percentage="0.00";
	}
	$("#monthpercentage").html(percentage);
}

$("#monthlist").html("");
<team-rows>
	var userguestnum = parseInt(${fld:guest_target});
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
	var monthlist="<h1 class='gg-task-hd'>${fld:name}<span class='desc-btn' onclick=teamdetail(${fld:pk_value})>详情</span></h1>"
			+"<ul class='gg-task-mid' style='margin-bottom: 0;padding-bottom: 0;'>"
			+"<li><p class='num-wrap'><span class='num'>${fld:usernum}<i style='color: #848999' id='month${fld:pk_value}rate'></i></span></p>"
			+"<p>人员达标率</p><span class='sep'></span></li><li>"
			+"<p class='num-wrap'><span class='num'>${fld:guestnum}</span>个</p>"
			+"<p>获客数量</p><span class='sep'></span></li><li>"
			+"<p class='num-wrap'><span class='num'>${fld:guest_target}</span>个</p>"
			+"<p>任务总量</p></li></ul><ul class='gg-task-ft'>"
			+"<li><span class='label'>任务完成比例</span><div class='progress'>"
			+"<span class='progress-play' id='progress-play${fld:pk_value}'></span></div>"
			+"<span class='percent'>"+percentage+"%</span></li></ul>";
	$("#monthlist").append(monthlist);
	$("#progress-play${fld:pk_value}").css("width", (percentage>100?100:percentage)+"%");

	var url="${def:actionroot}/monthsuccessrate?monthdateinfo=${fld:monthdateinfo}&team_id=${fld:pk_value}";
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


var count = 0, counttwo = 0, monthstaff = "", countthr = 0, counttarget = 0;
<target-rows>
$("#monthtargetnum").html(${fld:guest_target});
count++;
</target-rows>
if(count==0){
	$("#monthtargetnum").html(0);
}

<monthguest-rows>
$("#monthguestnum").html(${fld:monthguestnum});
counttwo++;
</monthguest-rows>
if(counttwo==0){
	$("#monthguestnum").html(0);
}

/**组员*/
$("#monthstaff").html("");
<staff-rows>
	countthr++;
	var userguestnum = parseInt(${fld:userguestnum});
	var guestnum = parseInt(${fld:guestnum});
	if(isNaN(userguestnum)){
		userguestnum = 0;
	}
	//判断本月组员是否完成任务
	if(guestnum>=userguestnum&&userguestnum>0){
		counttarget++;
	}
	var percentage = 0;
	if(guestnum>0&&userguestnum==0){
		percentage = 100;
	}else if(guestnum==0&&userguestnum==0){
		percentage = 0.00;
	}else{
		percentage = Number(guestnum/userguestnum*100).toFixed(0);
	}
	monthstaff="<li><span class='serial'>"+countthr+".</span><span class='nickname'>${fld:name}</span>"
			  +"<span class='get-num'>收集${fld:guestnum}</span><div class='progress'><span class='progress-play' id='progress-play${fld:userlogin}'></span>"
			  +"</div><span class='percent' style='margin-left: 2px'>"+percentage+"%</span></li>";

	$("#monthstaff").append(monthstaff);
	$("#progress-play${fld:userlogin}").css("width", (percentage>100?100:percentage)+"%");
</staff-rows>
$("#completenum").html("/"+counttarget);


var zongguestnum = parseInt($("#monthguestnum").html());
var zongtargetnum = parseInt($("#monthtargetnum").html());
var zongpercentage = 0;
if(zongguestnum>0&&zongtargetnum==0){
	zongpercentage = 100;
}else if(zongguestnum==0&&zongtargetnum==0){
	zongpercentage = 0.00;
}else{
	zongpercentage = Number(zongguestnum/zongtargetnum*100).toFixed(0);
}
$("#zongpercentage").html(zongpercentage+"%");
$(".zongmonth-progress-play").css("width", (zongpercentage>100?100:zongpercentage)+"%");


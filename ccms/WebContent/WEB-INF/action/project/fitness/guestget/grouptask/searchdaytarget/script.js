
var count = 0, counttwo = 0, monthstaff = "", countthr = 0, counttarget = 0;
var date = new Date("${fld:daydateinfo}");
var year = date.getFullYear();
var month = date.getMonth()+1;
var daynum = new Date(year, month, 0).getDate();

<target-rows>
$("#daytargetnum").html(Math.ceil(parseInt(${fld:guest_target})/daynum));
count++;
</target-rows>
if(count==0){
	$("#daytargetnum").html(0);
}

<dayhkbguest-rows>
$("#dayguestnum").html(${fld:monthguestnum});
counttwo++;
</dayhkbguest-rows>
if(counttwo==0){
	$("#dayguestnum").html(0);
}

//**组员*//*
$("#daystaff").html("");
<staff-rows>
	countthr++;
	var userguestnum = Math.ceil(parseInt(${fld:userguestnum})/daynum);
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
			  +"<span class='get-num'>收集${fld:guestnum}</span><div class='progress'><span class='progress-play' id='dayprogress-play${fld:userlogin}'></span>"
			  +"</div><span class='percent' style='margin-left: 2px'>"+percentage+"%</span></li>";

	$("#daystaff").append(monthstaff);
	$("#dayprogress-play${fld:userlogin}").css("width", (percentage>100?100:percentage)+"%");
</staff-rows>
$("#completedaynum").html("/"+counttarget);


var zongguestnum = parseInt($("#dayguestnum").html());
var zongtargetnum = parseInt($("#daytargetnum").html());
var zongpercentage = 0;
if(zongguestnum>0&&zongtargetnum==0){
	zongpercentage = 100;
}else if(zongguestnum==0&&zongtargetnum==0){
	zongpercentage = 0.00;
}else{
	zongpercentage = Number(zongguestnum/zongtargetnum*100).toFixed(0);
}
$("#zongdaypercentage").html(zongpercentage+"%");
$(".zongday-progress-play").css("width", (zongpercentage>100?100:zongpercentage)+"%");



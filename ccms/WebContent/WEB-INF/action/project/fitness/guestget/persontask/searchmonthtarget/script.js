
var count = 0, guest_target = 0, monthguestnum = 0;
<target-rows>
$("#monthtargetnum").html(${fld:guest_target});
guest_target = ${fld:guest_target};
count++;
</target-rows>
if(count==0){
	$("#monthtargetnum").html(0);
}

$("#monthguestnum").html("${fld:monthguestnum}");
monthguestnum = ${fld:monthguestnum};

if(monthguestnum>0&&parseInt(guest_target)==0){
	$("#monthpercentage").html("100%");
	$(".month-progress-play").css("width", "100%");
}else if(monthguestnum==0&&parseInt(guest_target)==0){
	$("#monthpercentage").html("0.00%");
	$(".month-progress-play").css("width", "0.00%");
}else{
	var percentage = Number(monthguestnum/guest_target*100).toFixed(2);
	$("#monthpercentage").html(percentage+"%");
	$(".month-progress-play").css("width", (percentage>100?100:percentage)+"%");
}

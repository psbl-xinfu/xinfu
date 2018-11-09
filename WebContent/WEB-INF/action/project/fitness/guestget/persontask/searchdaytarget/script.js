
var date = new Date("${fld:daydateinfo}");
var year = date.getFullYear();
var month = date.getMonth()+1;
var daynum = new Date(year, month, 0).getDate();

var dayguestnum = ${fld:dayguestnum};
$("#dayguestnum").html(dayguestnum);

var guest_target = 0;
<target-rows>
	guest_target = Math.ceil(parseInt(${fld:guest_target})/daynum);
</target-rows>
$("#daytargetnum").html(guest_target);

if(dayguestnum>0&&guest_target==0){
	$("#daypercentage").html("100%");
	$(".day-progress-play").css("width", "100%");
}else if(dayguestnum==0&&guest_target==0){
	$("#daypercentage").html("0.00%");
	$(".day-progress-play").css("width", "0.00%");
}else{
	var percentage = Number(dayguestnum/guest_target*100).toFixed(2);
	$("#daypercentage").html(percentage+"%");
	$(".day-progress-play").css("width", (percentage>100?100:percentage)+"%");
}
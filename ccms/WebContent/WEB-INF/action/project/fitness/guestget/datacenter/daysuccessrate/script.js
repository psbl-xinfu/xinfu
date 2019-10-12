
var date = new Date("${fld:daydateinfo}");
var year = date.getFullYear();
var month = date.getMonth()+1;
var daynum = new Date(year, month, 0).getDate();

var counttarget = 0;
<staff-rows>
	var userguestnum = Math.ceil(parseInt(${fld:userguestnum})/daynum);
	var guestnum = parseInt(${fld:guestnum});
	if(isNaN(userguestnum)){
		userguestnum = 0;
	}
	//判断本月组员是否完成任务
	if(guestnum>=userguestnum&&userguestnum>0){
		counttarget++;
	}
</staff-rows>
$("#day${fld:team_id}rate").html("/"+counttarget);

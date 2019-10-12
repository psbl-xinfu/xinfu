
var counttarget = 0;
<staff-rows>
	var userguestnum = parseInt(${fld:userguestnum});
	var guestnum = parseInt(${fld:guestnum});
	if(isNaN(userguestnum)){
		userguestnum = 0;
	}
	//判断本月组员是否完成任务
	if(guestnum>=userguestnum&&userguestnum>0){
		counttarget++;
	}
</staff-rows>
$("#month${fld:team_id}rate").html("/"+counttarget);

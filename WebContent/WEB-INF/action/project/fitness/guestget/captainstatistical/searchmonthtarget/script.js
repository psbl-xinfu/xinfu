
var monthstaff = "";

/**组员*/
$("#monthstaff").html("");
<staff-rows>
	var userguestnum = parseInt(${fld:userguestnum});
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
	monthstaff+="<tr id='list'><td>${fld:name}</td><td>${fld:team_name}</td><td>"
		+userguestnum+"</td><td>"+guestnum+"</td><td>"+percentage+"%</td></tr>";

</staff-rows>
$("#monthstaff").html(monthstaff);




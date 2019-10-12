
<custenddays-rows>
	$("#custenddays").html("${fld:days}<i>天</i>");
</custenddays-rows>

var inleftnum = parseInt("${fld:inleftnum}");
var inlefthbnum = parseInt("${fld:inlefthbnum}");
var val = 0, hbstr = "";
if(inleftnum==0&&inlefthbnum==0){
	hbstr = "环比 ↑ 0%";
}else if(inleftnum==0){
	hbstr = "环比 ↓ 0%";
}else if(inlefthbnum==0){
	hbstr = "环比 ↑ 0%";
}else{
	var target = inleftnum-inlefthbnum;
	var val = (target*100)/inlefthbnum;
	if(val<0){
		hbstr = "环比 ↓ "+(-val.toFixed(2))+"%";
	}else{
		hbstr = "环比 ↑ "+val.toFixed(2)+"%";
	}
}

$("#inleftnum").html(inleftnum+"<i>次</i><c>"+hbstr+"</c>");


<averageinleft-rows>
	$("#times").html("${fld:times@HH.mm}<i>min</i>");
</averageinleft-rows>




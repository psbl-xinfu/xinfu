/** 入场数 */
var todayNum = parseInt("${fld:todayinleft}"), premonthNum = parseInt("${fld:premonthinleft}");
$("#todayinleft").text(todayNum);
$("#premonthinleft").text(premonthNum);
var premonthinleftrate = 0;
if( 0 != parseInt(todayNum) && 0 != parseInt(premonthNum) 
		&& parseInt(todayNum) != parseInt(premonthNum) && !isNaN(todayNum) && !isNaN(premonthNum) ){
	premonthinleftrate = (parseInt(todayNum) - parseInt(premonthNum))*100/parseInt(premonthNum);
}
if( premonthinleftrate >= 0 ){
	$("#premonthinleftrate").parent().removeClass("down");
}else{
	$("#premonthinleftrate").parent().addClass("down");
}
judgePercentage("premonthinleftrate", premonthinleftrate);
$("#monthinleft").text("${fld:monthinleft}");

/** 资源到访数 */
todayNum = parseInt("${fld:todayvisit}"), premonthNum = parseInt("${fld:premonthvisit}");
$("#todayvisit").text(todayNum);
$("#premonthvisit").text(premonthNum);
var premonthvisitrate = 0;
if( 0 != parseInt(todayNum) && 0 != parseInt(premonthNum) 
		&& parseInt(todayNum) != parseInt(premonthNum) && !isNaN(todayNum) && !isNaN(premonthNum) ){
	premonthvisitrate = (parseInt(todayNum) - parseInt(premonthNum))*100/parseInt(premonthNum);
}
if( premonthvisitrate >= 0 ){
	$("#premonthvisitrate").parent().removeClass("down");
}else{
	$("#premonthvisitrate").parent().addClass("down");
}
judgePercentage("premonthvisitrate", premonthvisitrate);
$("#monthvisit").text("${fld:monthvisit}");

/** 资源陌生到访数 */
todayNum = parseInt("${fld:msnum}"), premonthNum = parseInt("${fld:premonthmsnum}");
$("#todayms").text(todayNum);
$("#premonthms").text(premonthNum);
var premonthmsrate = 0;
if( 0 != parseInt(todayNum) && 0 != parseInt(premonthNum) 
		&& parseInt(todayNum) != parseInt(premonthNum) && !isNaN(todayNum) && !isNaN(premonthNum) ){
	premonthmsrate = (parseInt(todayNum) - parseInt(premonthNum))*100/parseInt(premonthNum);
}
if( premonthmsrate >= 0 ){
	$("#premonthmsrate").parent().removeClass("down");
}else{
	$("#premonthmsrate").parent().addClass("down");
}
judgePercentage("premonthmsrate", premonthmsrate);
$("#monthmsnum").text("${fld:monthmsnum}");

/** 资源预约到访数 */
todayNum = parseInt("${fld:yynum}"), premonthNum = parseInt("${fld:premonthyynum}");
$("#todayyy").text(todayNum);
$("#premonthyy").text(premonthNum);
var premonthyyrate = 0;
if( 0 != parseInt(todayNum) && 0 != parseInt(premonthNum) 
		&& parseInt(todayNum) != parseInt(premonthNum) && !isNaN(todayNum) && !isNaN(premonthNum) ){
	premonthyyrate = (parseInt(todayNum) - parseInt(premonthNum))*100/parseInt(premonthNum);
}
if( premonthyyrate >= 0 ){
	$("#premonthyyrate").parent().removeClass("down");
}else{
	$("#premonthyyrate").parent().addClass("down");
}
judgePercentage("premonthyyrate", premonthyyrate);
$("#monthyynum").text("${fld:monthyynum}");

/** 私教签课数 */
todayNum = parseInt("${fld:todaypt}"), premonthNum = parseInt("${fld:premonthpt}");
$("#todaypt").text((isNaN(todayNum) ? 0 : todayNum));
$("#premonthpt").text((isNaN(premonthNum) ? 0 : premonthNum));
var premonthptrate = 0;
if( 0 != parseInt(todayNum) && 0 != parseInt(premonthNum) 
		&& parseInt(todayNum) != parseInt(premonthNum) && !isNaN(todayNum) && !isNaN(premonthNum) ){
	premonthptrate = (parseInt(todayNum) - parseInt(premonthNum))*100/parseInt(premonthNum);
}
if( premonthptrate >= 0 ){
	$("#premonthptrate").parent().removeClass("down");
}else{
	$("#premonthptrate").parent().addClass("down");
}
judgePercentage("premonthptrate", premonthptrate);
$("#monthpt").text("${fld:monthpt}");

/** 团操上课数 */
todayNum = parseInt("${fld:todayclass}"), premonthNum = parseInt("${fld:premonthclass}");
$("#todayclass").text((isNaN(todayNum) ? 0 : todayNum));
$("#premonthclass").text((isNaN(premonthNum) ? 0 : premonthNum));
var premonthclassrate = 0;
if( 0 != parseInt(todayNum) && 0 != parseInt(premonthNum) 
		&& parseInt(todayNum) != parseInt(premonthNum) && !isNaN(todayNum) && !isNaN(premonthNum) ){
	premonthclassrate = (parseInt(todayNum) - parseInt(premonthNum))*100/parseInt(premonthNum);
}
if( premonthclassrate >= 0 ){
	$("#premonthclassrate").parent().removeClass("down");
}else{
	$("#premonthclassrate").parent().addClass("down");
}
judgePercentage("premonthclassrate", premonthclassrate);
$("#monthclass").text((isNaN("${fld:monthclass}")||"${fld:monthclass}"=='' ? 0 : "${fld:monthclass}"));

function judgePercentage(id, percentage){
	if(percentage>100){percentage = 100;}
	if(percentage<-100){percentage = -100;}
	$("#"+id).text(Number(percentage).toFixed(2)+"%");
}
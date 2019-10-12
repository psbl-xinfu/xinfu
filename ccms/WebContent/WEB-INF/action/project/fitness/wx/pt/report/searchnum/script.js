//上课课时
$("#ptdefcount").html("${fld:ptdefcount}课时");
//课程预约
$("#guestnum").html("${fld:guestnum}人");
//体验课
$("#tiyancount").html("${fld:tiyancount}人");

var date = new Date("${def:date}");
var year = date.getFullYear();
var month = date.getMonth()+1;
//当月天数
var daynum = new Date(year, month, 0).getDate();

var ordercount = 0, orderfee_target = 0, monthtarget = 0;
<orderfeetarget-rows>
orderfee_target = Number("${fld:orderfee_target}");
ordercount++;
</orderfeetarget-rows>
//判断当前月有没有设置销售金额
if(ordercount==0){
	orderfee_target = 0;
}else{
	//判断按月日查询
	if("${fld:type}"!="0"){
		monthtarget = orderfee_target;
		orderfee_target = orderfee_target/daynum;
	}else{
		monthtarget = orderfee_target/daynum;
	}
}

var money = 0;

<cardmoney-rows>
	money+=Number("${fld:factmoney}");
</cardmoney-rows>

$("#targetpercentage").html((money/monthtarget*100).toFixed(2)+"%");

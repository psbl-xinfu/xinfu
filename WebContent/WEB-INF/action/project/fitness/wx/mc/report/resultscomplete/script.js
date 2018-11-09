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

var cardmoney = [], percentage = 0, money = 0;

cardsalesinfo.total = 0;
cardsalesinfo.xdataArr = [], cardsalesinfo.seriesDataArr = [];
var arr = [];
for(var i =0;i<new Date().getDate();i++){
	var datestr = "";
	if(i<9){
		datestr = '2018-04-0'+(i+1);
	}else{
		datestr = '2018-04-'+(i+1);
	}
	cardmoney[i] = 0;
	arr[i] = datestr;
	cardsalesinfo.xdataArr[i] = datestr;
	cardsalesinfo.total++;
}
<cardmoney-rows>
	//判断当前月有没有设置销售金额
	if(ordercount==0){
		percentage = 100;
	}else{
		percentage = (Number("${fld:factmoney}")/orderfee_target*100).toFixed(2);
	}
	for(var i =0;i<arr.length;i++){
		if(arr[i]=="${fld:createdate}"){
			cardmoney[i] = percentage;
		}
	}
	money+=Number("${fld:factmoney}");
</cardmoney-rows>
cardsalesinfo.seriesDataArr = [cardmoney];

//$("#targetpercentage").html((money/monthtarget*100).toFixed(2)+"%");

if( cardsalesinfo.total > 0 ){
	initLineBarCharts("cardsalesDiv", cardsalesinfo, 'bar');
}else{
	$("#cardsalesDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

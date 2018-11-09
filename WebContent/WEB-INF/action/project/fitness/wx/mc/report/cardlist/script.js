var seriesArr = [], othernum = 0, othermoney = 0, count = 0, cardlistinfo = "", num = 0, money = 0;
<card-rows>
	if(count<5){
		cardlistinfo+="<li><span>${fld:name}</span><span>${fld:num}单</span><span>"+(Number("${fld:factmoney}")/10000).toFixed(2)+"W</span></li>";
		seriesArr[count] = {value: "${fld:num}", name: "${fld:name}"};
	}else{
		othernum += parseInt("${fld:num}");
		othermoney += Number("${fld:factmoney}");
	}
	num += parseInt("${fld:num}");
	money += Number("${fld:factmoney}");
	count++;
</card-rows>
if(othernum>0){
	cardlistinfo+="<li><span>其他</span><span>"+othernum+"单</span><span>"+(othermoney/10000).toFixed(2)+"W</span></li>";
	seriesArr[seriesArr.length] = {value: othernum+"", name: "其他"};
}

if(seriesArr.length>0){
	$("#cardmoney").html((money/10000).toFixed(2)+"W");
	$("#cardnum").html(num+"单");
	cardlistPic.createCharts(seriesArr);
	$("#cardlistinfo").html(cardlistinfo);
}else{
	$("#cardmoney").html("0W");
	$("#cardnum").html("0单");
	$("#cardlistinfo").html("");
	$("#cardlistDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

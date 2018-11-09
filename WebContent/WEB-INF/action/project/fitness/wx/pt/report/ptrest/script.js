var seriesArr = [], othernum = 0, othermoney = 0, count = 0, ptrestinfo = "", num = 0, money = 0;
<ptrest-rows>
	if(count<5){
		ptrestinfo+="<li><span>${fld:name}</span><span>${fld:num}单</span><span>"+(Number("${fld:factmoney}")/10000).toFixed(2)+"W</span></li>";
		seriesArr[count] = {value: "${fld:num}", name: "${fld:name}"};
	}else{
		othernum += parseInt("${fld:num}");
		othermoney += Number("${fld:factmoney}");
	}
	num += parseInt("${fld:num}");
	money += Number("${fld:factmoney}");
	count++;
</ptrest-rows>
if(othernum>0){
	ptrestinfo+="<li><span>其他</span><span>"+othernum+"单</span><span>"+(othermoney/10000).toFixed(2)+"W</span></li>";
	seriesArr[seriesArr.length] = {value: othernum+"", name: "其他"};
}

if(seriesArr.length>0){
	$("#ptrestmoney").html((money/10000).toFixed(2)+"W");
	$("#ptrestnum").html(num+"单");
	ptrestPic.createCharts(seriesArr);
	$("#ptrestinfo").html(ptrestinfo);
}else{
	$("#ptrestmoney").html("0W");
	$("#ptrestnum").html("0单");
	$("#ptrestinfo").html("");
	$("#ptrestDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

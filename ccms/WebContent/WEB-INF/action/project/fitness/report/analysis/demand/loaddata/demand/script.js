var seriesArr = [];
var count = 0, num = 0;
<demand-rows>
	if(count<5){
		seriesArr[count] = {value: "${fld:num}", name: "${fld:domain_text_cn}"};
	}else{
		num+=parseInt("${fld:num}");
	}
	count++;
</demand-rows>
seriesArr[seriesArr.length] = {value: num, name: "其他"};

if(seriesArr.length>0){
	demandPic.createCharts(seriesArr);
	//列表
	pielist("demand", seriesArr);
}else{
	$("#demandDiv,#demandDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

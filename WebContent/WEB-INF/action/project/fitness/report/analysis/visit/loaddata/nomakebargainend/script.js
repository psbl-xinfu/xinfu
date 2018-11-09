$("#nomakebargainDiv").html("");
var seriesArr = [];
var count = 0;
<comm-rows>
	seriesArr[count] = {value: "${fld:num}", name: "${fld:domain_text_cn}"};
	count++;
</comm-rows>
if(seriesArr.length>0){
	nomakebargainendPic.createCharts(seriesArr);
	//列表
	pielist("nomakebargain", seriesArr);
}else{
	$("#nomakebargainDiv,#nomakebargainDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

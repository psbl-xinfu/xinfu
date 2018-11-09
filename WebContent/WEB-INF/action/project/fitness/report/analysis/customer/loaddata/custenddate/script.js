$("#custDiv").html("");
var seriesArr = [
	{value: "${fld:onenum}", name: '3个月内', selected: true},
	{value: "${fld:twonum}", name: '3-6个月'},
	{value: "${fld:threenum}", name: '6-12个月'},
	{value: "${fld:fournum}", name: '1年以上'}
];
if(${fld:onenum}==0&&${fld:twonum}==0&&${fld:threenum}==0&&${fld:fournum}==0){
	$("#custDiv,#custDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}else{
	custendPic.createCharts(seriesArr);
	//列表
	pielist("cust", seriesArr);
}
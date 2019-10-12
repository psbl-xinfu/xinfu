/** 首节课续费 */
firstcttnCharts.total = 0;
firstcttnCharts.legendData = [], firstcttnCharts.seriesDataArr = [];
var firstcttnlist = [];

firstcttnCharts.seriesDataArr[firstcttnCharts.total] = "${fld:iscttn}";
firstcttnCharts.legendData[firstcttnCharts.total] = "首次课续费";
firstcttnlist[firstcttnCharts.total] = {value: "${fld:iscttn}", name: '首次课续费'};
firstcttnCharts.total++;
firstcttnCharts.seriesDataArr[firstcttnCharts.total] = "${fld:notiscttn}";
firstcttnCharts.legendData[firstcttnCharts.total] = "首次课未续费";
firstcttnlist[firstcttnCharts.total] = {value: "${fld:notiscttn}", name: '首次课未续费'};

if( firstcttnCharts.total > 0 ){
	initPieCharts("firstcttnDiv", firstcttnCharts);
	//列表
	pielist("firstcttn", firstcttnlist);
}else{
	$("#firstcttnDiv,#firstcttnDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

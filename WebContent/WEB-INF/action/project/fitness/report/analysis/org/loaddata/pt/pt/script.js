/** 耗课率 */
ptCharts.total = 0;
ptCharts.legendData = [], ptCharts.seriesDataArr = [];
var ptlist = [];
ptCharts.seriesDataArr[ptCharts.total] = parseInt("${fld:hknum}");
ptCharts.legendData[ptCharts.total] = "耗课总数";
ptlist[ptCharts.total] = {value: parseInt("${fld:hknum}"), name: '耗课总数'};
ptCharts.total++;
ptCharts.seriesDataArr[ptCharts.total] = (parseInt("${fld:num}")-parseInt("${fld:hknum}"));
ptCharts.legendData[ptCharts.total] = "剩余课时";
ptlist[ptCharts.total] = {value: (parseInt("${fld:num}")-parseInt("${fld:hknum}")), name: '剩余课时'};

if( ptCharts.total > 0 ){
	initPieCharts("ptDiv", ptCharts);
	//列表
	pielist("pt", ptlist);
}else{
	$("#ptDiv,#ptDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}


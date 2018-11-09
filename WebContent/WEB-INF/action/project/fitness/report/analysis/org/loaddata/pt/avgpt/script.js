/** 平均授课量 */
var dataNumArr = [];

avgptCharts.total = 0;
avgptCharts.xdataArr = [], avgptCharts.seriesDataArr = [];
<rows>
avgptCharts.xdataArr[avgptCharts.total] = "${fld:createdate}";
dataNumArr[avgptCharts.total] = parseInt("${fld:num}");
avgptCharts.total++;
</rows>
avgptCharts.legendData = ['平均授课量'];
avgptCharts.seriesDataArr = [dataNumArr];

var tbAvgptdataArr = [], tbTotal = 0;
<tb-rows>
tbAvgptdataArr[tbTotal] = parseInt("${fld:num}");
tbTotal++;
</tb-rows>
if( tbTotal > 0 ){
	avgptCharts.legendData.push("平均授课量[同]");
	avgptCharts.seriesDataArr.push(tbAvgptdataArr);
}

var hbAvgptdataArr = [], hbTotal = 0;
<hb-rows>
hbAvgptdataArr[hbTotal] = parseInt("${fld:num}");
hbTotal++;
</hb-rows>
if( hbTotal > 0 ){
	avgptCharts.legendData.push("平均授课量[环]");
	avgptCharts.seriesDataArr.push(hbAvgptdataArr);
}

if( avgptCharts.total > 0 ){
	initLineBarCharts("avgptDiv", avgptCharts);
}else{
	$("#avgptDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

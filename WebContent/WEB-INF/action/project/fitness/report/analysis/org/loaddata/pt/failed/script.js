/** 未成交原因指数 */
failedCharts.total = 0;
failedCharts.legendData = [], failedCharts.seriesDataArr = [];
var failedlist = [];
<rows>
failedCharts.seriesDataArr[failedCharts.total] = parseInt("${fld:num}");
failedCharts.legendData[failedCharts.total] = "${fld:descr@js}";
failedlist[failedCharts.total] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
failedCharts.total++;
</rows>

failedCharts.seriesDataArrOther = [], failedCharts.legendDataOther = [], idx = 0;
<tb-rows>
failedCharts.othertitlename = failedCharts.titlename + "[同]";
failedCharts.seriesDataArrOther[idx] = parseInt("${fld:num}");
failedCharts.legendDataOther[idx] = "${fld:descr@js}";
failedlist[failedlist.length] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
idx++;
</tb-rows>

<hb-rows>
failedCharts.othertitlename = failedCharts.titlename + "[环]";
failedCharts.seriesDataArrOther[idx] = parseInt("${fld:num}");
failedCharts.legendDataOther[idx] = "${fld:descr@js}";
failedlist[failedlist.length] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
idx++;
</hb-rows>

if( failedCharts.total > 0 ){
	initPieCharts("failedDiv", failedCharts);
	//列表
	pielist("failed", failedlist);
}else{
	$("#failedDiv,#failedDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

/** 渠道占比指数 */
sourceCharts.total = 0;
sourceCharts.legendData = [], sourceCharts.seriesDataArr = [];
var guestsourcelist = [];
<rows>
sourceCharts.seriesDataArr[sourceCharts.total] = parseInt("${fld:num}");
sourceCharts.legendData[sourceCharts.total] = "${fld:descr@js}";
guestsourcelist[sourceCharts.total] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
sourceCharts.total++;
</rows>

sourceCharts.seriesDataArrOther = [], sourceCharts.legendDataOther = [], idx = 0;
<tb-rows>
sourceCharts.othertitlename = sourceCharts.titlename + "[同]";
sourceCharts.seriesDataArrOther[idx] = parseInt("${fld:num}");
sourceCharts.legendDataOther[idx] = "${fld:descr@js}";
guestsourcelist[guestsourcelist.length] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
idx++;
</tb-rows>

<hb-rows>
sourceCharts.othertitlename = sourceCharts.titlename + "[环]";
sourceCharts.seriesDataArrOther[idx] = parseInt("${fld:num}");
sourceCharts.legendDataOther[idx] = "${fld:descr@js}";
guestsourcelist[guestsourcelist.length] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
idx++;
</hb-rows>


if( sourceCharts.total > 0 ){
	initPieCharts("sourceDiv", sourceCharts);
	//列表
	pielist("source", guestsourcelist);
}else{
	$("#sourceDiv,#sourceDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

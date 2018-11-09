/** 未成交原因指数 */
guestreasonCharts.total = 0;
guestreasonCharts.legendData = [], guestreasonCharts.seriesDataArr = [];
var guestreasonlist = [];
<rows>
guestreasonCharts.seriesDataArr[guestreasonCharts.total] = parseInt("${fld:num}");
guestreasonCharts.legendData[guestreasonCharts.total] = "${fld:descr@js}";
guestreasonlist[guestreasonCharts.total] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
guestreasonCharts.total++;
</rows>

guestreasonCharts.seriesDataArrOther = [], guestreasonCharts.legendDataOther = [], idx = 0;
<tb-rows>
guestreasonCharts.othertitlename = guestreasonCharts.titlename + "[同]";
guestreasonCharts.seriesDataArrOther[idx] = parseInt("${fld:num}");
guestreasonCharts.legendDataOther[idx] = "${fld:descr@js}";
guestreasonlist[guestreasonlist.length] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
idx++;
</tb-rows>

<hb-rows>
guestreasonCharts.othertitlename = guestreasonCharts.titlename + "[环]";
guestreasonCharts.seriesDataArrOther[idx] = parseInt("${fld:num}");
guestreasonCharts.legendDataOther[idx] = "${fld:descr@js}";
guestreasonlist[guestreasonlist.length] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
idx++;
</hb-rows>

if( guestreasonCharts.total > 0 ){
	initPieCharts("guestreasonDiv", guestreasonCharts);
	//列表
	pielist("guestreason", guestreasonlist);
}else{
	$("#guestreasonDiv,#guestreasonDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

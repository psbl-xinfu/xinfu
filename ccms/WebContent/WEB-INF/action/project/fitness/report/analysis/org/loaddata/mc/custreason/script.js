/** 未续费原因指数 */
custreasonCharts.total = 0;
custreasonCharts.legendData = [], custreasonCharts.seriesDataArr = [];
var custreasonlist = [];
<rows>
custreasonCharts.seriesDataArr[custreasonCharts.total] = parseInt("${fld:num}");
custreasonCharts.legendData[custreasonCharts.total] = "${fld:descr@js}";
custreasonlist[custreasonCharts.total] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
custreasonCharts.total++;
</rows>

custreasonCharts.seriesDataArrOther = [], custreasonCharts.legendDataOther = [], idx = 0;
<tb-rows>
custreasonCharts.othertitlename = custreasonCharts.titlename + "[同]";
custreasonCharts.seriesDataArrOther[idx] = parseInt("${fld:num}");
custreasonCharts.legendDataOther[idx] = "${fld:descr@js}";
custreasonlist[custreasonlist.length] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
idx++;
</tb-rows>

<hb-rows>
custreasonCharts.othertitlename = custreasonCharts.titlename + "[环]";
custreasonCharts.seriesDataArrOther[idx] = parseInt("${fld:num}");
custreasonCharts.legendDataOther[idx] = "${fld:descr@js}";
custreasonlist[custreasonlist.length] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
idx++;
</hb-rows>

if( custreasonCharts.total > 0 ){
	initPieCharts("custreasonDiv", custreasonCharts);
	//列表
	pielist("custreason", custreasonlist);
}else{
	$("#custreasonDiv,#custreasonDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

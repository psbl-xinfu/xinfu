/** 渠道未成交占比指数 */
guestsourceCharts.total = 0;
guestsourceCharts.legendData = [], guestsourceCharts.seriesDataArr = [];
var sourcelist = [];
<rows>
guestsourceCharts.seriesDataArr[guestsourceCharts.total] = parseInt("${fld:num}");
guestsourceCharts.legendData[guestsourceCharts.total] = "${fld:descr@js}";
sourcelist[guestsourceCharts.total] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
guestsourceCharts.total++;
</rows>

guestsourceCharts.seriesDataArrOther = [], guestsourceCharts.legendDataOther = [], idx = 0;
<tb-rows>
guestsourceCharts.othertitlename = guestsourceCharts.titlename + "[同]";
guestsourceCharts.seriesDataArrOther[idx] = parseInt("${fld:num}");
guestsourceCharts.legendDataOther[idx] = "${fld:descr@js}";
sourcelist[sourcelist.length] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
idx++;
</tb-rows>

<hb-rows>
guestsourceCharts.othertitlename = guestsourceCharts.titlename + "[环]";
guestsourceCharts.seriesDataArrOther[idx] = parseInt("${fld:num}");
guestsourceCharts.legendDataOther[idx] = "${fld:descr@js}";
sourcelist[sourcelist.length] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
idx++;
</hb-rows>

if( guestsourceCharts.total > 0 ){
	initPieCharts("guestsourceDiv", guestsourceCharts);
	//列表
	pielist("guestsource", sourcelist);
}else{
	$("#guestsourceDiv,#guestsourceDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

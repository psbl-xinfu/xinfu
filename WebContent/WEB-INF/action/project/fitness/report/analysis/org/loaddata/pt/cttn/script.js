/** 首节课续费 */
cttnCharts.total = 0;
cttnCharts.legendData = [], cttnCharts.seriesDataArr = [];
var cttnlist = [];

var custTotal = 0, custBargain = 0;
<cttn-rows>
custTotal++;
if( "1" == "${fld:iscttn}" ){
	custBargain++;
}
</cttn-rows>
if( custTotal > 0 ){
	cttnCharts.seriesDataArr[cttnCharts.total] = custBargain;
	cttnCharts.legendData[cttnCharts.total] = "首节课续费";
	cttnlist[cttnCharts.total] = {value: custBargain, name: '首节课续费'};
	cttnCharts.total++;
	cttnCharts.seriesDataArr[cttnCharts.total] = custTotal - custBargain;
	cttnCharts.legendData[cttnCharts.total] = "首节课未续费";
	cttnlist[cttnCharts.total] = {value: (custTotal - custBargain), name: '首节课未续费'};
}

if( cttnCharts.total > 0 ){
	initPieCharts("cttnDiv", cttnCharts);
	//列表
	pielist("cttn", cttnlist);
}else{
	$("#cttnDiv,#cttnDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

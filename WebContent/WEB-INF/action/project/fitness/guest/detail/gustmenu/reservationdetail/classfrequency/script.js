/** 上课频率趋势分析  **/
var classrest = [];

frequency.total = 0;
frequency.xdataArr = [], frequency.seriesDataArr = [];
<rows>
	frequency.xdataArr[frequency.total] = "${fld:createdate}";
	classrest[frequency.total] = ${fld:num};
	frequency.total++;
</rows>
frequency.legendData = ['上课频率趋势分析 '];
frequency.seriesDataArr = [classrest];

if( frequency.total > 0 ){
	initLineBarCharts("classFrequencyDiv", frequency, 'line');
}

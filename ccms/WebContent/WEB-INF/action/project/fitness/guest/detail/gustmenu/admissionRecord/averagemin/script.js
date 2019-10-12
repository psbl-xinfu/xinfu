/** 在场时长统计  **/
var avgfee = [];

averagemin.total = 0;
averagemin.xdataArr = [], averagemin.seriesDataArr = [];
<rows>
	averagemin.xdataArr[averagemin.total] = "${fld:createdate}";
	avgfee[averagemin.total] = Number(parseInt("${fld:num}")/60).toFixed(1);
	averagemin.total++;
</rows>
averagemin.legendData = ['在场时长统计 '];
averagemin.seriesDataArr = [avgfee];

if( averagemin.total > 0 ){
	initLineBarCharts("averageminDiv", averagemin, 'line');
}

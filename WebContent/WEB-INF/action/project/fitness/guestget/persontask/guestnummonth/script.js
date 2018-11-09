
var avgfee = [];

guestnummonth.total = 0;
guestnummonth.xdataArr = [], guestnummonth.seriesDataArr = [];
<rows>
	guestnummonth.xdataArr[guestnummonth.total] = "${fld:createdate}";
	avgfee[guestnummonth.total] = ${fld:num};
	guestnummonth.total++;
</rows>
guestnummonth.seriesDataArr = [avgfee];

if( guestnummonth.total > 0 ){
	initLineBarCharts("guestnummonthDiv", guestnummonth, 'bar');
}else{
	$("#guestnummonthDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

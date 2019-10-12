
/** 客流量 **/
var trafficnum1 = [];

trafficnum.total = 0;
trafficnum.xdataArr = [], custnum.seriesDataArr = [];
<rows>
	trafficnum.xdataArr[trafficnum.total] = "${fld:createdate}";
	trafficnum1[custnum.total] = "${fld:num}";
	trafficnum.total++;
</rows>
trafficnum.seriesDataArr = [trafficnum1];
if( trafficnum.total > 0 ){
	initLineBarCharts("trafficDiv", trafficnum);
}
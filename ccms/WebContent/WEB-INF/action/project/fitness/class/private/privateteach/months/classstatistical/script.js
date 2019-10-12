/** 入场统计 **/
var avgfee = [];

inleft.total = 0;
inleft.xdataArr = [], inleft.seriesDataArr = [];
<rows>
	inleft.xdataArr[inleft.total] = "${fld:createdate}";
	avgfee[inleft.total] = ${fld:num};
	inleft.total++;
</rows>
inleft.legendData = ['入场统计'];
inleft.seriesDataArr = [avgfee];

if( inleft.total > 0 ){
	initLineBarCharts("inleftDiv", inleft, 'line');
}

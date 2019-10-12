/** 入场统计 **/
var avgfee = [];

inleft.total = 0;
inleft.xdataArr = [], inleft.seriesDataArr = [];
var yearnum = 0;
<rows>
	inleft.xdataArr[inleft.total] = "${fld:createdate}";
	avgfee[inleft.total] = ${fld:num};
	yearnum+=${fld:num};
	inleft.total++;
	console.log("${fld:createdate}:${fld:num}");
</rows>
inleft.legendData = ['入场统计'];
inleft.seriesDataArr = [avgfee];
$("#yearnum").html(yearnum);
if( inleft.total > 0 ){
	initLineBarCharts("inleftDiv", inleft, 'line');
}


/** 会员入场人数 **/
var custnum1 = [];

custnum.total = 0;
custnum.xdataArr = [], custnum.seriesDataArr = [];
<rows>
	custnum.xdataArr[custnum.total] = "${fld:createdate}";
	custnum1[custnum.total] = "${fld:num}";
	custnum.total++;
</rows>
custnum.seriesDataArr = [custnum1];
if( custnum.total > 0 ){
	initLineBarCharts("custentrancenumDiv", custnum);
}
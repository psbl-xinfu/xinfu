
/** 团操上课数 **/
var cnum1 = [];

cnum.total = 0;
cnum.xdataArr = [], cnum.seriesDataArr = [];
<rows>
	cnum.xdataArr[cnum.total] = "${fld:createdate}";
	cnum1[cnum.total] = "${fld:num}";
	cnum.total++;
</rows>

cnum.seriesDataArr = [cnum1];
if( cnum.total > 0 ){
	initLineBarCharts("classnumDiv", cnum);
}
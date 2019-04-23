/** 课时单比均价 */
var fee = 0;	/** 总价格 */
var num = 0;	/** 总数量 */
var avgfee = 0;	/*** 课时单比均价 = 课时总费用/私教合同数 */
var feedataArr = [];

feeCharts.total = 0;
feeCharts.xdataArr = [], feeCharts.seriesDataArr = [];
<rows>
feeCharts.xdataArr[feeCharts.total] = "${fld:createdate}";
fee = parseFloat("${fld:fee}");
num = parseInt("${fld:num}");
avgfee = (parseFloat(fee)/parseFloat(num == 0 ? 1 : num)).toFixed(0);
feedataArr[feeCharts.total] = avgfee;
feeCharts.total++;
</rows>
feeCharts.seriesDataArr = [feedataArr];

if( feeCharts.total > 0 ){
	initLineBarCharts("feeDiv", feeCharts);
}

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
avgfee = (num == 0 ? 0 : parseFloat(fee)/parseFloat(num)).toFixed(0);
feedataArr[feeCharts.total] = avgfee;
feeCharts.total++;
</rows>
feeCharts.legendData = ['课时单比均价'];
feeCharts.seriesDataArr = [feedataArr];

var tbFeedataArr = [], tbTotal = 0;
<tb-rows>
fee = parseFloat("${fld:fee}");
num = parseInt("${fld:num}");
avgfee = (num == 0 ? 0 : parseFloat(fee)/parseFloat(num)).toFixed(0);
tbFeedataArr[tbTotal] = avgfee;
tbTotal++;
</tb-rows>
if( tbTotal > 0 ){
	feeCharts.legendData.push("课时单比均价[同]");
	feeCharts.seriesDataArr.push(tbFeedataArr);
}

var hbFeedataArr = [], hbTotal = 0;
<hb-rows>
fee = parseFloat("${fld:fee}");
num = parseInt("${fld:num}");
avgfee = (num == 0 ? 0 : parseFloat(fee)/parseFloat(num)).toFixed(0);
hbFeedataArr[hbTotal] = avgfee;
hbTotal++;
</hb-rows>
if( hbTotal > 0 ){
	feeCharts.legendData.push("课时单比均价[环]");
	feeCharts.seriesDataArr.push(hbFeedataArr);
}

if( feeCharts.total > 0 ){
	initLineBarCharts("feeDiv", feeCharts);
}else{
	$("#feeDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}


/** 产品均价 */
var cardNum = 0;	/** 销售量 */
var cardFee = 0;	/** 销售金额 */
var avgfee = [];

avgcardCharts.total = 0;
avgcardCharts.xdataArr = [], avgcardCharts.seriesDataArr = [];
<rows>
avgcardCharts.xdataArr[avgcardCharts.total] = "${fld:createdate}";
cardNum = parseInt("${fld:num}");
cardFee = parseFloat("${fld:fee}");
avgfee[avgcardCharts.total] = (cardNum == 0 ? 0 : parseFloat(cardFee)/parseFloat(cardNum)).toFixed(0);
avgcardCharts.total++;
</rows>
avgcardCharts.legendData = ['产品均价'];
avgcardCharts.seriesDataArr = [avgfee];

var tbAvgCarddataArr = [], tbTotal = 0;
<tb-rows>
cardNum = parseInt("${fld:num}");
cardFee = parseFloat("${fld:fee}");
tbAvgCarddataArr[tbTotal] = (cardNum == 0 ? 0 : parseFloat(cardFee)/parseFloat(cardNum)).toFixed(0);
tbTotal++;
</tb-rows>
if( tbTotal > 0 ){
	avgcardCharts.legendData.push("产品均价[同]");
	avgcardCharts.seriesDataArr.push(tbAvgCarddataArr);
}

var hbAvgCarddataArr = [], hbTotal = 0;
<hb-rows>
cardNum = parseInt("${fld:num}");
cardFee = parseFloat("${fld:fee}");
hbAvgCarddataArr[hbTotal] = (cardNum == 0 ? 0 : parseFloat(cardFee)/parseFloat(cardNum)).toFixed(0);
hbTotal++;
</hb-rows>
if( hbTotal > 0 ){
	avgcardCharts.legendData.push("产品均价[环]");
	avgcardCharts.seriesDataArr.push(hbAvgCarddataArr);
}

if( avgcardCharts.total > 0 ){
	initLineBarCharts("avgcardDiv", avgcardCharts);
}else{
	$("#avgcardDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

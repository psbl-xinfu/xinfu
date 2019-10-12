/** 产品均价 */
var cardNum = 0;	/** 销售量 */
var cardFee = 0;	/** 销售金额 */
var avgfee = [];

price.total = 0;
price.xdataArr = [], price.seriesDataArr = [];
<rows>
price.xdataArr[price.total] = "${fld:createdate}";
cardNum = parseInt("${fld:num}");
cardFee = parseFloat("${fld:fee}");
avgfee[price.total] = (parseFloat(cardFee)/parseFloat(cardNum == 0 ? 1 : cardNum)).toFixed(0);
price.total++;
</rows>
price.legendData = ['产品均价'];
price.seriesDataArr = [avgfee];

if( price.total > 0 ){
	initLineBarCharts("productpriceDiv", price);
}else{
	$("#productpriceDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

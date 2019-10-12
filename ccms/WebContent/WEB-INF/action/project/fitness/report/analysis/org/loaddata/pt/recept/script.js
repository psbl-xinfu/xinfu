/** POS接待率 */
var custNum = 0;	/** 成交总人数 */
var experNum = 0;	/** 体验课总人数 */
var compRate = 0;	/** POS接待率 = POS教练接待数并成交/当天办卡人数 */
var posArr = [];

receptCharts.total = 0;
receptCharts.xdataArr = [], receptCharts.seriesDataArr = [];
<rows>
receptCharts.xdataArr[receptCharts.total] = "${fld:createdate}";
custNum = parseInt("${fld:cust_num}");
experNum = parseInt("${fld:exper_num}");
compRate = (experNum == 0 ? 0 : parseFloat(custNum)*100.00/parseFloat(experNum)).toFixed(0);
compRate = (compRate > 100 ? 100 : compRate);
posArr[receptCharts.total] = parseInt(compRate);
receptCharts.total++;
</rows>
receptCharts.legendData = ['POS接待率'];
receptCharts.seriesDataArr = [posArr];

/** 同比 */
var tbPosArr = [], tbTotal = 0;
<tb-rows>
receptCharts.xdataArr[tbTotal] = "${fld:createdate}";
custNum = parseInt("${fld:cust_num}");
experNum = parseInt("${fld:exper_num}");
compRate = (experNum == 0 ? 0 : parseFloat(custNum)*100.00/parseFloat(experNum)).toFixed(0);
compRate = (compRate > 100 ? 100 : compRate);
tbPosArr[tbTotal] = parseInt(compRate);
tbTotal++;
</tb-rows>
if( tbTotal > 0 ){
	receptCharts.legendData.push("POS接待率[同]");
	receptCharts.seriesDataArr.push(tbPosArr);
}

/** 环比 */
var hbPosArr = [], hbTotal = 0;
<hb-rows>
receptCharts.xdataArr[hbTotal] = "${fld:createdate}";
custNum = parseInt("${fld:cust_num}");
experNum = parseInt("${fld:exper_num}");
compRate = (experNum == 0 ? 0 : parseFloat(custNum)*100.00/parseFloat(experNum)).toFixed(0);
compRate = (compRate > 100 ? 100 : compRate);
hbPosArr[hbTotal] = parseInt(compRate);
hbTotal++;
</hb-rows>
if( hbTotal > 0 ){
	receptCharts.legendData.push("POS接待率[环]");
	receptCharts.seriesDataArr.push(hbPosArr);
}

if( receptCharts.total > 0 ){
	initLineBarCharts("receptDiv", receptCharts);
}else{
	$("#receptDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

/** 综合成交率 */
var custNum = 0;	/** 成交总人数 */
var p1CustNum = 0;	/** P1成交人数 */
var p2CustNum = 0;	/** P2成交人数 */
var p1Num = 0;	/** P1人数 */
var p2Num = 0;	/** P2人数 */
var experNum = 0;	/** 体验课总人数 */
var compRate = 0;	/*** 综合成交率 = 成交总人数/体验课总人数 */
var p1Rate = 0;	/** P1成交率 = P1成交人数/P1人数 */
var p2Rate = 0;	/** P2成交率 = P2成交人数/P2人数 */
var posArr = [], p1Arr = [], p2Arr = [];

posCharts.total = 0;
posCharts.xdataArr = [], posCharts.seriesDataArr = [];
<rows>
posCharts.xdataArr[posCharts.total] = "${fld:createdate}";
custNum = parseInt("${fld:cust_num}");
p1CustNum = parseInt("${fld:p1_cust_num}");
p2CustNum = parseInt("${fld:p2_cust_num}");
p1Num = parseInt("${fld:p1_num}");
p2Num = parseInt("${fld:p2_num}");
experNum = parseInt("${fld:exper_num}");
compRate = (experNum == 0 ? 0 : parseFloat(custNum)*100.00/parseFloat(experNum)).toFixed(0);
compRate = (compRate > 100 ? 100 : compRate);
p1Rate = (p1Num == 0  ? 0 : parseFloat(p1CustNum)*100.00/parseFloat(p1Num)).toFixed(0);
p1Rate = (p1Rate > 100 ? 100 : p1Rate);
p2Rate = (p2Num == 0  ? 0 : parseFloat(p2CustNum)*100.00/parseFloat(p2Num)).toFixed(0);
p2Rate = (p2Rate > 100 ? 100 : p2Rate);
posArr[posCharts.total] = parseInt(compRate);
p1Arr[posCharts.total] = parseInt(p1Rate);
p2Arr[posCharts.total] = parseInt(p2Rate);
posCharts.total++;
</rows>
posCharts.legendData = ['POS','P1','P2'];
posCharts.seriesDataArr = [posArr, p1Arr, p2Arr];

/** 同比 */
var tbPosArr = [], tbP1Arr = [], tbP2Arr = [], tbTotal = 0;
<tb-rows>
custNum = parseInt("${fld:cust_num}");
p1CustNum = parseInt("${fld:p1_cust_num}");
p2CustNum = parseInt("${fld:p2_cust_num}");
p1Num = parseInt("${fld:p1_num}");
p2Num = parseInt("${fld:p2_num}");
experNum = parseInt("${fld:exper_num}");
compRate = (experNum == 0 ? 0 : parseFloat(custNum)*100.00/parseFloat(experNum)).toFixed(0);
compRate = (compRate > 100 ? 100 : compRate);
p1Rate = (p1Num == 0 ? 0 : parseFloat(p1CustNum)*100.00/parseFloat(p1Num)).toFixed(0);
p1Rate = (p1Rate > 100 ? 100 : p1Rate);
p2Rate = (p2Num == 0 ? 0 : parseFloat(p2CustNum)*100.00/parseFloat(p2Num)).toFixed(0);
p2Rate = (p2Rate > 100 ? 100 : p2Rate);
tbPosArr[tbTotal] = parseInt(compRate);
tbP1Arr[tbTotal] = parseInt(p1Rate);
tbP2Arr[tbTotal] = parseInt(p2Rate);
tbTotal++;
</tb-rows>
if( tbTotal > 0 ){
	posCharts.legendData.push("POS[同]");
	posCharts.seriesDataArr.push(tbPosArr);
	posCharts.legendData.push("P1[同]");
	posCharts.seriesDataArr.push(tbP1Arr);
	posCharts.legendData.push("P2[同]");
	posCharts.seriesDataArr.push(tbP2Arr);
}

/** 环比 */
var hbPosArr = [], hbP1Arr = [], hbP2Arr = [], hbTotal = 0;
<hb-rows>
custNum = parseInt("${fld:cust_num}");
p1CustNum = parseInt("${fld:p1_cust_num}");
p2CustNum = parseInt("${fld:p2_cust_num}");
p1Num = parseInt("${fld:p1_num}");
p2Num = parseInt("${fld:p2_num}");
experNum = parseInt("${fld:exper_num}");
compRate = (experNum == 0 ? 0 : parseFloat(custNum)*100.00/parseFloat(experNum)).toFixed(0);
compRate = (compRate > 100 ? 100 : compRate);
p1Rate = (p1Num == 0 ? 0 : parseFloat(p1CustNum)*100.00/parseFloat(p1Num)).toFixed(0);
p1Rate = (p1Rate > 100 ? 100 : p1Rate);
p2Rate = (p2Num == 0 ? 0 : parseFloat(p2CustNum)*100.00/parseFloat(p2Num)).toFixed(0);
p2Rate = (p2Rate > 100 ? 100 : p2Rate);
hbPosArr[hbTotal] = parseInt(compRate);
hbP1Arr[hbTotal] = parseInt(p1Rate);
hbP2Arr[hbTotal] = parseInt(p2Rate);
hbTotal++;
</hb-rows>
if( hbTotal > 0 ){
	posCharts.legendData.push("POS[环]");
	posCharts.seriesDataArr.push(hbPosArr);
	posCharts.legendData.push("P1[环]");
	posCharts.seriesDataArr.push(hbP1Arr);
	posCharts.legendData.push("P2[环]");
	posCharts.seriesDataArr.push(hbP2Arr);
}

if( posCharts.total > 0 ){
	initLineBarCharts("posDiv", posCharts);
}else{
	$("#posDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

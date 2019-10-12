/** POS接待率 */
var custNum = 0;	/** 成交总人数 */
var experNum = 0;	/** 体验课总人数 */
var compRate = 0;	/** POS接待率 = 成交总人数/体验课总人数 */
var posArr = [];

receptCharts.total = 0;
receptCharts.xdataArr = [], receptCharts.seriesDataArr = [];
<rows>
receptCharts.xdataArr[receptCharts.total] = "${fld:createdate}";
custNum = parseInt("${fld:cust_num}");
experNum = parseInt("${fld:exper_num}");
compRate = (parseFloat(custNum)*100.00/parseFloat(experNum == 0 ? 1 : experNum)).toFixed(0);
compRate = (compRate > 100 ? 100 : compRate);
posArr[receptCharts.total] = parseInt(compRate);
receptCharts.total++;
</rows>
receptCharts.seriesDataArr = [posArr];

if( receptCharts.total > 0 ){
	initLineBarCharts("receptDiv", receptCharts);
}

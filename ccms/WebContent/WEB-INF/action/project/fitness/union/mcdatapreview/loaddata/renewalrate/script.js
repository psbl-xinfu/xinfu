/** 续费率 */
var toCttnNum = 0;	/** 将到期数 */
var cttNum = 0;	/** 续费数 */
var cttnRate = [];	/** 续费率 */

rate.total = 0;
rate.xdataArr = [], rate.seriesDataArr = [];
<rows>
rate.xdataArr[rate.total] = "${fld:createdate}";
toCttnNum = parseInt("${fld:num}");
cttNum = parseInt("${fld:num1}");
cttnRate[rate.total] = (parseFloat(cttNum)*100.00/parseFloat(toCttnNum == 0 ? 1 : toCttnNum)).toFixed(0);
rate.total++;
</rows>
rate.legendData = ['续费率'];
rate.seriesDataArr = [cttnRate];

var tbCttnCarddataArr = [], tbTotal = 0;
<tb-rows>
toCttnNum = parseInt("${fld:num}");
cttNum = parseInt("${fld:num1}");
tbCttnCarddataArr[tbTotal] = (parseFloat(cttNum)*100.00/parseFloat(toCttnNum == 0 ? 1 : toCttnNum)).toFixed(0);
tbTotal++;
</tb-rows>
if( tbTotal > 0 ){
	rate.legendData.push("续费率[同]");
	rate.seriesDataArr.push(tbCttnCarddataArr);
}

var hbCttnCarddataArr = [], hbTotal = 0;
<hb-rows>
toCttnNum = parseInt("${fld:num}");
cttNum = parseInt("${fld:num1}");
hbCttnCarddataArr[hbTotal] = (parseFloat(cttNum)*100.00/parseFloat(toCttnNum == 0 ? 1 : toCttnNum)).toFixed(0);
hbTotal++;
</hb-rows>
if( hbTotal > 0 ){
	rate.legendData.push("续费率[环]");
	rate.seriesDataArr.push(hbCttnCarddataArr);
}

if( rate.total > 0 ){
	initLineBarCharts("renewalrateDiv", rate);
}else{
	$("#renewalrateDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

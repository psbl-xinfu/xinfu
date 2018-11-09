/** 续费率 */
var toCttnNum = 0;	/** 将到期数 */
var cttNum = 0;	/** 续费数 */
var cttnRate = [];	/** 续费率 */

cttncardCharts.total = 0;
cttncardCharts.xdataArr = [], cttncardCharts.seriesDataArr = [];
<rows>
cttncardCharts.xdataArr[cttncardCharts.total] = "${fld:createdate}";
toCttnNum = parseInt("${fld:num}");
cttNum = parseInt("${fld:num1}");
cttnRate[cttncardCharts.total] = (toCttnNum == 0 ? 0 : parseFloat(cttNum)*100.00/parseFloat(toCttnNum)).toFixed(0);
cttncardCharts.total++;
</rows>
cttncardCharts.legendData = ['续费率'];
cttncardCharts.seriesDataArr = [cttnRate];

var tbCttnCarddataArr = [], tbTotal = 0;
<tb-rows>
toCttnNum = parseInt("${fld:num}");
cttNum = parseInt("${fld:num1}");
tbCttnCarddataArr[tbTotal] = (toCttnNum == 0 ? 0 : parseFloat(cttNum)*100.00/parseFloat(toCttnNum)).toFixed(0);
tbTotal++;
</tb-rows>
if( tbTotal > 0 ){
	cttncardCharts.legendData.push("续费率[同]");
	cttncardCharts.seriesDataArr.push(tbCttnCarddataArr);
}

var hbCttnCarddataArr = [], hbTotal = 0;
<hb-rows>
toCttnNum = parseInt("${fld:num}");
cttNum = parseInt("${fld:num1}");
hbCttnCarddataArr[hbTotal] = (toCttnNum == 0 ? 0 : parseFloat(cttNum)*100.00/parseFloat(toCttnNum)).toFixed(0);
hbTotal++;
</hb-rows>
if( hbTotal > 0 ){
	cttncardCharts.legendData.push("续费率[环]");
	cttncardCharts.seriesDataArr.push(hbCttnCarddataArr);
}

if( cttncardCharts.total > 0 ){
	initLineBarCharts("cttncardDiv", cttncardCharts);
}else{
	$("#cttncardDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

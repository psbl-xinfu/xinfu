/** 总和到访量 */
var strangeVisitNum = 0;	/** 陌生到访量 */
var strangeFinishNum = 0;	/** 陌生成交量 */
var prepareVisitNum = 0;	/** 预约到访量 */
var prepareFinishNum = 0;	/** 预约成交量 */
var visitNum = 0;	/** 总到访量 */
var finishNum = 0;	/** 总成交量 */

var strangeFinishArr = [], prepareFinishArr = [], totalFinishArr = [];
var strangeVisitArr = [], prepareVisitJson = {}, prepareFinishJson = {};
<prepare-rows>
prepareVisitJson["${fld:createdate}"] = parseInt("${fld:num}");
prepareFinishJson["${fld:createdate}"] = parseInt("${fld:num1}");
</prepare-rows>

inclubCharts.total = 0;
inclubCharts.xdataArr = [], inclubCharts.seriesDataArr = [];
<strange-rows>
strangeVisitNum = parseInt("${fld:num}");
strangeFinishNum = parseInt("${fld:num1}");
prepareVisitNum = prepareVisitJson["${fld:createdate}"];
prepareFinishNum = prepareFinishJson["${fld:createdate}"];
visitNum = parseInt(strangeVisitNum) + parseInt(prepareVisitNum);
finishNum = parseInt(strangeFinishNum) + parseInt(prepareFinishNum);

inclubCharts.xdataArr[inclubCharts.total] = "${fld:createdate}";
strangeFinishArr[inclubCharts.total] = (strangeFinishNum == 0 ? 0 : parseFloat(strangeVisitNum)*100.00/parseFloat(strangeFinishNum)).toFixed(0);
prepareFinishArr[inclubCharts.total] = (prepareFinishNum == 0 ? 0 : parseFloat(prepareVisitNum)*100.00/parseFloat(prepareFinishNum)).toFixed(0);
totalFinishArr[inclubCharts.total] = (finishNum == 0 ? 0 : parseFloat(visitNum)*100.00/parseFloat(finishNum)).toFixed(0);
inclubCharts.total++;
</strange-rows>
inclubCharts.legendData = ['预约成交率','陌生成交率','综合成交率'];
inclubCharts.seriesDataArr = [prepareFinishArr, strangeVisitArr, totalFinishArr];


var tbstrangeFinishArr = [], tbprepareFinishArr = [], tbtotalFinishArr = [], tbTotal = 0;
<tb-rows>
strangeVisitNum = parseInt("${fld:num}");
strangeFinishNum = parseInt("${fld:num1}");
prepareVisitNum = prepareVisitJson["${fld:createdate}"];
prepareFinishNum = prepareFinishJson["${fld:createdate}"];
visitNum = parseInt(strangeVisitNum) + parseInt(prepareVisitNum);
finishNum = parseInt(strangeFinishNum) + parseInt(prepareFinishNum);

tbstrangeFinishArr[tbTotal] = (strangeFinishNum == 0 ? 0 : parseFloat(strangeVisitNum)*100.00/parseFloat(strangeFinishNum)).toFixed(0);
tbprepareFinishArr[tbTotal] = (prepareFinishNum == 0 ? 0 : parseFloat(prepareVisitNum)*100.00/parseFloat(prepareFinishNum)).toFixed(0);
tbtotalFinishArr[tbTotal] = (finishNum == 0 ? 0 : parseFloat(visitNum)*100.00/parseFloat(finishNum)).toFixed(0);
tbTotal++;
</tb-rows>
if( tbTotal > 0 ){
	inclubCharts.legendData.push("预约成交率[同]");
	inclubCharts.seriesDataArr.push(tbprepareFinishArr);
	inclubCharts.legendData.push("陌生成交率[同]");
	inclubCharts.seriesDataArr.push(tbstrangeFinishArr);
	inclubCharts.legendData.push("综合成交率[同]");
	inclubCharts.seriesDataArr.push(tbtotalFinishArr);
}

var hbstrangeFinishArr = [], hbprepareFinishArr = [], hbtotalFinishArr = [], hbTotal = 0;
<hb-rows>
strangeVisitNum = parseInt("${fld:num}");
strangeFinishNum = parseInt("${fld:num1}");
prepareVisitNum = prepareVisitJson["${fld:createdate}"];
prepareFinishNum = prepareFinishJson["${fld:createdate}"];
visitNum = parseInt(strangeVisitNum) + parseInt(prepareVisitNum);
finishNum = parseInt(strangeFinishNum) + parseInt(prepareFinishNum);

hbstrangeFinishArr[hbTotal] = (strangeFinishNum == 0 ? 0 : parseFloat(strangeVisitNum)*100.00/parseFloat(strangeFinishNum)).toFixed(0);
hbprepareFinishArr[hbTotal] = (prepareFinishNum == 0 ? 0 : parseFloat(prepareVisitNum)*100.00/parseFloat(prepareFinishNum)).toFixed(0);
hbtotalFinishArr[hbTotal] = (finishNum == 0 ? 0 : parseFloat(visitNum)*100.00/parseFloat(finishNum)).toFixed(0);
hbTotal++;
</hb-rows>
if( hbTotal > 0 ){
	inclubCharts.legendData.push("预约成交率[环]");
	inclubCharts.seriesDataArr.push(hbprepareFinishArr);
	inclubCharts.legendData.push("陌生成交率[环]");
	inclubCharts.seriesDataArr.push(hbstrangeFinishArr);
	inclubCharts.legendData.push("综合成交率[环]");
	inclubCharts.seriesDataArr.push(hbtotalFinishArr);
}

if( inclubCharts.total > 0 ){
	initLineBarCharts("inclubDiv", inclubCharts);
}else{
	$("#inclubDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

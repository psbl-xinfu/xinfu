
/** 综合成交率 **/

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

mccomprehensive.total = 0;
mccomprehensive.xdataArr = [], mccomprehensive.seriesDataArr = [];
<strange-rows>
strangeVisitNum = parseInt("${fld:num}");
strangeFinishNum = parseInt("${fld:num1}");
prepareVisitNum = prepareVisitJson["${fld:createdate}"];
prepareFinishNum = prepareFinishJson["${fld:createdate}"];
visitNum = parseInt(strangeVisitNum) + parseInt(prepareVisitNum);
finishNum = parseInt(strangeFinishNum) + parseInt(prepareFinishNum);

mccomprehensive.xdataArr[mccomprehensive.total] = "${fld:createdate}";
strangeFinishArr[mccomprehensive.total] = (parseFloat(strangeVisitNum)*100.00/parseFloat(strangeFinishNum == 0 ? 1 : strangeFinishNum)).toFixed(0);
prepareFinishArr[mccomprehensive.total] = (parseFloat(prepareVisitNum)*100.00/parseFloat(prepareFinishNum == 0 ? 1 : prepareFinishNum)).toFixed(0);
totalFinishArr[mccomprehensive.total] = (parseFloat(visitNum)*100.00/parseFloat(finishNum == 0 ? 1 : finishNum)).toFixed(0);
mccomprehensive.total++;
</strange-rows>
mccomprehensive.seriesDataArr = [prepareFinishArr, strangeVisitArr, totalFinishArr];

if( mccomprehensive.total > 0 ){
	initLineBarCharts("mccomprehensiveclosingDiv", mccomprehensive);
}else{
	$("#mccomprehensiveclosingDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

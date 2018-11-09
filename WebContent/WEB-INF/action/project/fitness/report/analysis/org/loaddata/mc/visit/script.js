/** 总和到访量 */
var strangeVisitNum = 0;	/** 陌生到访量 */
var prepareVisitNum = 0;	/** 预约到访量 */
var avgVisitNum = 0;	/** 平均到访量 */
var strangeVisitArr = [], prepareVisitArr = [], avgVisitArr = [];

var prepareVisitJson = {};
<prepare-rows>
prepareVisitJson["${fld:createdate}"] = parseInt("${fld:num}");
</prepare-rows>

visitCharts.total = 0;
visitCharts.xdataArr = [], visitCharts.seriesDataArr = [];
<strange-rows>
strangeVisitNum = parseInt("${fld:num}");
prepareVisitNum = prepareVisitJson["${fld:createdate}"];
avgVisitNum = (parseInt(strangeVisitNum) + parseInt(prepareVisitNum))/2;

visitCharts.xdataArr[visitCharts.total] = "${fld:createdate}";
strangeVisitArr[visitCharts.total] = strangeVisitNum;
prepareVisitArr[visitCharts.total] = prepareVisitNum;
avgVisitArr[visitCharts.total] = avgVisitNum;
visitCharts.total++;
</strange-rows>
visitCharts.legendData = ['陌生到访量','平均到访量','预约到访量'];
visitCharts.seriesDataArr = [strangeVisitArr, avgVisitArr, prepareVisitArr];


var tbstrangeVisitArr = [], tbprepareVisitArr = [], tbavgVisitArr = [], tbTotal = 0;
<tb-rows>
strangeVisitNum = parseInt("${fld:num}");
prepareVisitNum = prepareVisitJson["${fld:createdate}"];
avgVisitNum = (parseInt(strangeVisitNum) + parseInt(prepareVisitNum))/2;

tbstrangeVisitArr[tbTotal] = strangeVisitNum;
tbprepareVisitArr[tbTotal] = prepareVisitNum;
tbavgVisitArr[tbTotal] = avgVisitNum;
tbTotal++;
</tb-rows>
if( tbTotal > 0 ){
	visitCharts.legendData.push("陌生到访量[同]");
	visitCharts.seriesDataArr.push(tbstrangeVisitArr);
	visitCharts.legendData.push("平均到访量[同]");
	visitCharts.seriesDataArr.push(tbavgVisitArr);
	visitCharts.legendData.push("预约到访量[同]");
	visitCharts.seriesDataArr.push(tbprepareVisitArr);
}

var hbstrangeVisitArr = [], hbprepareVisitArr = [], hbavgVisitArr = [], hbTotal = 0;
<hb-rows>
strangeVisitNum = parseInt("${fld:num}");
prepareVisitNum = prepareVisitJson["${fld:createdate}"];
avgVisitNum = (parseInt(strangeVisitNum) + parseInt(prepareVisitNum))/2;

hbstrangeVisitArr[hbTotal] = strangeVisitNum;
hbprepareVisitArr[hbTotal] = prepareVisitNum;
hbavgVisitArr[hbTotal] = avgVisitNum;
hbTotal++;
</hb-rows>
if( hbTotal > 0 ){
	visitCharts.legendData.push("陌生到访量[环]");
	visitCharts.seriesDataArr.push(hbstrangeVisitArr);
	visitCharts.legendData.push("平均到访量[环]");
	visitCharts.seriesDataArr.push(hbavgVisitArr);
	visitCharts.legendData.push("预约到访量[环]");
	visitCharts.seriesDataArr.push(hbprepareVisitArr);
}

if( visitCharts.total > 0 ){
	initLineBarCharts("visitDiv", visitCharts);
}else{
	$("#visitDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

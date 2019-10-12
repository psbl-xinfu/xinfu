$("#inleftDiv").html("");
/** 入场客流 */
var totalArr = [], visitArr = [], inleftArr = [];
var inleftJson = {}, dateArr = [];
<inleft-rows>
inleftJson["${fld:createdate}"] = parseInt("${fld:num}");
dateArr[dateArr.length] = "${fld:createdate}";
</inleft-rows>

var thisCharts = chartsObj[${fld:idx}];
thisCharts.total = 0;
thisCharts.xdataArr = [], thisCharts.seriesDataArr = [];
var visitJosn = {};
<visit-rows>
if( !isInArray(dateArr,"${fld:createdate}") ){
	dateArr[dateArr.length] = "${fld:createdate}";
}
visitJosn["${fld:createdate}"] = parseInt("${fld:num}");
</visit-rows>

for(var i = 0; i < dateArr.length; i++){
	thisCharts.xdataArr[thisCharts.total] = dateArr[i];
	visitArr[thisCharts.total] = getIntegerValue(visitJosn[dateArr[i]],0);
	inleftArr[thisCharts.total] = getIntegerValue(inleftJson[dateArr[i]],0);
	totalArr[thisCharts.total] = parseInt(getIntegerValue(visitJosn[dateArr[i]],0)) + parseInt(getIntegerValue(inleftJson[dateArr[i]],0));
	thisCharts.total++;
}
thisCharts.legendData = ["入场人数", "资源到访人数", "会员入场人数"];
thisCharts.seriesDataArr = [totalArr, visitArr, inleftArr];

var tbTotal = 0, tbvisitArr = [], tbinleftArr = [], tbtotalArr = [];
var tbinleftJson = {}, tbDateArr = [], tbvisitJosn = {};
<tb-rows-left>
tbinleftJson["${fld:createdate}"] = parseInt("${fld:num}");
tbDateArr[tbDateArr.length] = "${fld:createdate}";
</tb-rows-left>
<tb-rows>
if( !isInArray(tbDateArr,"${fld:createdate}") ){
	tbDateArr[tbDateArr.length] = "${fld:createdate}";
}
tbvisitJosn["${fld:createdate}"] = parseInt("${fld:num}");
</tb-rows>
for(var i = 0; i < tbDateArr.length; i++){
	tbvisitArr[tbTotal] = getIntegerValue(tbvisitJosn[tbDateArr[i]],0);
	tbinleftArr[tbTotal] = getIntegerValue(tbinleftJson[tbDateArr[i]],0);
	tbtotalArr[tbTotal] = parseInt(getIntegerValue(tbvisitJosn[tbDateArr[i]],0)) + parseInt(getIntegerValue(tbinleftJson[tbDateArr[i]],0));
	tbTotal++;
}
if( tbTotal > 0 ){
	thisCharts.legendData.push("入场人数[同]");
	thisCharts.seriesDataArr.push(tbvisitArr);
	thisCharts.legendData.push("资源到访 人数[同]");
	thisCharts.seriesDataArr.push(tbinleftArr);
	thisCharts.legendData.push("会员入场人数[同]");
	thisCharts.seriesDataArr.push(tbtotalArr);
}

var hbTotal = 0, hbvisitArr = [], hbinleftArr = [], hbtotalArr = [];
var hbinleftJson = {}, hbDateArr = [], hbvisitJosn = {};
<hb-rows-left>
hbinleftJson["${fld:createdate}"] = parseInt("${fld:num}");
hbDateArr[hbDateArr.length] = "${fld:createdate}";
</hb-rows-left>
<hb-rows>
if( !isInArray(hbDateArr,"${fld:createdate}") ){
	hbDateArr[hbDateArr.length] = "${fld:createdate}";
}
hbvisitJosn["${fld:createdate}"] = parseInt("${fld:num}");
</hb-rows>
for(var i = 0; i < hbDateArr.length; i++){
	hbvisitArr[hbTotal] = getIntegerValue(hbvisitJosn[hbDateArr[i]],0);
	hbinleftArr[hbTotal] = getIntegerValue(hbinleftJson[hbDateArr[i]],0);
	hbtotalArr[hbTotal] = parseInt(getIntegerValue(hbvisitJosn[hbDateArr[i]],0)) + parseInt(getIntegerValue(hbinleftJson[hbDateArr[i]],0));
	hbTotal++;
}
if( hbTotal > 0 ){
	thisCharts.legendData.push("入场人数[环]");
	thisCharts.seriesDataArr.push(hbvisitArr);
	thisCharts.legendData.push("资源到访 人数[环]");
	thisCharts.seriesDataArr.push(hbinleftArr);
	thisCharts.legendData.push("会员入场人数[环]");
	thisCharts.seriesDataArr.push(hbtotalArr);
}

if( thisCharts.total > 0 ){
	var darea = $("div[code=chartsgroup]:eq(${fld:idx})").data("area");
	thisCharts.obj = initLineBarCharts(darea+"Div", thisCharts);
}else{
	$("#inleftDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

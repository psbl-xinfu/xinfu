$("#ptclassDiv").html("");
/** 私教团操上课数 */
var totalArr = [], clsArr = [], ptArr = [];
var ptJson = {}, dateArr = [];
<pt-rows>
ptJson["${fld:createdate}"] = parseInt("${fld:num}");
dateArr[dateArr.length] = "${fld:createdate}";
</pt-rows>

var thisCharts = chartsObj[${fld:idx}];
thisCharts.total = 0;
thisCharts.xdataArr = [], thisCharts.seriesDataArr = [];
var clsJson = {};
<cls-rows>
if( !isInArray(dateArr,"${fld:createdate}") ){
	dateArr[dateArr.length] = "${fld:createdate}";
}
clsJson["${fld:createdate}"] = parseInt(""=="${fld:num}"?"0":"${fld:num}");
</cls-rows>
for(var i = 0; i < dateArr.length; i++){
	thisCharts.xdataArr[thisCharts.total] = dateArr[i];
	clsArr[thisCharts.total] = getIntegerValue(clsJson[dateArr[i]],0);
	ptArr[thisCharts.total] = getIntegerValue(ptJson[dateArr[i]],0);
	totalArr[thisCharts.total] = parseInt(getIntegerValue(clsJson[dateArr[i]],0)) + parseInt(getIntegerValue(ptJson[dateArr[i]],0));
	thisCharts.total++;
}
thisCharts.legendData = ["团操人数","私数签课数"];
thisCharts.seriesDataArr = [clsArr, ptArr];

var tbTotal = 0, tbclsArr = [], tbptArr = [], tbtotalArr = [];
var tbptJson = {}, tbdateArr = [], tbclsJson = {};
<tb-pt-rows>
tbptJson["${fld:createdate}"] = parseInt("${fld:num}");
tbdateArr[tbdateArr.length] = "${fld:createdate}";
</tb-pt-rows>
<tb-rows>
if( !isInArray(tbdateArr,"${fld:createdate}") ){
	tbdateArr[tbdateArr.length] = "${fld:createdate}";
}
tbclsJson["${fld:createdate}"] = parseInt(""=="${fld:num}"?"0":"${fld:num}");
</tb-rows>
for(var i = 0; i < tbdateArr.length; i++){
	tbclsArr[tbTotal] = getIntegerValue(tbclsJson[tbdateArr[i]],0);
	tbptArr[tbTotal] = getIntegerValue(tbptJson[tbdateArr[i]],0);
	tbtotalArr[tbTotal] = parseInt(getIntegerValue(tbclsJson[tbdateArr[i]],0)) + parseInt(getIntegerValue(tbptJson[tbdateArr[i]],0));
	tbTotal++;
}
if( tbTotal > 0 ){
	thisCharts.legendData.push("团操人数[同]");
	thisCharts.seriesDataArr.push(tbclsArr);
	thisCharts.legendData.push("私数签课数[同]");
	thisCharts.seriesDataArr.push(tbptArr);
}

var hbTotal = 0, hbclsArr = [], hbptArr = [], hbtotalArr = [];
var hbptJson = {}, hbdateArr = [], hbclsJson = {};
<hb-pt-rows>
hbptJson["${fld:createdate}"] = parseInt("${fld:num}");
hbdateArr[hbdateArr.length] = "${fld:createdate}";
</hb-pt-rows>
<hb-rows>
if( !isInArray(hbdateArr,"${fld:createdate}") ){
	hbdateArr[hbdateArr.length] = "${fld:createdate}";
}
hbclsJson["${fld:createdate}"] = parseInt(""=="${fld:num}"?"0":"${fld:num}");
</hb-rows>
for(var i = 0; i < hbdateArr.length; i++){
	hbclsArr[hbTotal] = getIntegerValue(hbclsJson[hbdateArr[i]],0);
	hbptArr[hbTotal] = getIntegerValue(hbptJson[hbdateArr[i]],0);
	hbtotalArr[hbTotal] = parseInt(getIntegerValue(hbclsJson[hbdateArr[i]],0)) + parseInt(getIntegerValue(hbptJson[hbdateArr[i]],0));
	hbTotal++;
}
if( hbTotal > 0 ){
	thisCharts.legendData.push("团操人数[环]");
	thisCharts.seriesDataArr.push(hbclsArr);
	thisCharts.legendData.push("私数签课数[环]");
	thisCharts.seriesDataArr.push(hbptArr);
}

if( thisCharts.total > 0 ){
	var darea = $("div[code=chartsgroup]:eq(${fld:idx})").data("area");
	thisCharts.obj = initLineBarCharts(darea+"Div", thisCharts);
}else{
	$("#ptclassDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

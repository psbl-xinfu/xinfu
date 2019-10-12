/** 资源获取量 */
var newgustJson = {};
<newguest-rows>
	newgustJson["${fld:createdate}"] = ${fld:num};
</newguest-rows>

/** 跟进量 */
var followJson = {};
<follow-rows>
	followJson["${fld:createdate}"] = ${fld:num};
</follow-rows>

/** 预约量 */
var prepareJson = {};
<prepare-rows>
	prepareJson["${fld:createdate}"] = ${fld:num};
</prepare-rows>

/** 实际到访量/成单量 */
var visitJson = {}, sucJson = {};
<visit-rows>
	visitJson["${fld:createdate}"] = ${fld:visitnum};
	sucJson["${fld:createdate}"] = ${fld:sucnum};
</visit-rows>

/** 数据封装 */
var newgustData = [], followData = [], prepareData = [], visitData = [], sucData = [];
var fdate = "${fld:fdate@yyyy-MM-dd}";
var num = 0;
for(var i = 0; i < 7; i++){
	var thisdate = addDate(fdate, i).format("yyyy-MM-dd");
	newgustData[i] = getJsonValue(newgustJson, thisdate, 0);
	followData[i] = getJsonValue(followJson, thisdate, 0);
	prepareData[i] = getJsonValue(prepareJson, thisdate, 0);
	visitData[i] = getJsonValue(visitJson, thisdate, 0);
	sucData[i] = getJsonValue(sucJson, thisdate, 0);
	num+=getJsonValue(newgustJson, thisdate, 0);
	num+=getJsonValue(followJson, thisdate, 0);
	num+=getJsonValue(prepareJson, thisdate, 0);
	num+=getJsonValue(visitJson, thisdate, 0);
	num+=getJsonValue(sucJson, thisdate, 0);
}

/** 加载折线图 */
$("#taskDiv").empty();
var taskLine = new lineCharts("taskDiv");
taskLine.setConfig({isLegendShow: true, boundaryGap: false});
var taskSeriesData = [
	{name: "资源获取量", type: "line", data: newgustData},
	{name: "跟进量", type: "line", data: followData},
	{name: "预约量", type: "line", data: prepareData},
	{name: "实际到访量", type: "line", data: visitData},
	{name: "成单量",type: "line", data: sucData}
];
if(num>0){
	taskLine.updateOption(
			["资源获取量","跟进量","预约量","实际到访量","成单量"], 
			["周一","周二","周三","周四","周五","周六","周日"], 
			taskSeriesData
		);
}else{
	$("#taskDiv").html("<img alt='' src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png'>");
}

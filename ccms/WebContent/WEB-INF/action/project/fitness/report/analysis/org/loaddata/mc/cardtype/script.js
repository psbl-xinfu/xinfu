/** 产品销量占比 */
var otherNum = 0;
cardtypeCharts.total = 0;
cardtypeCharts.legendData = [], cardtypeCharts.seriesDataArr = [];
var cardtypelist = [];
<rows>
if( cardtypeCharts.total <= 4 ){
	cardtypeCharts.seriesDataArr[cardtypeCharts.total] = parseInt("${fld:num}");
	cardtypeCharts.legendData[cardtypeCharts.total] = "${fld:descr@js}";
	cardtypelist[cardtypeCharts.total] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
	cardtypeCharts.total++;
}else{
	otherNum += parseInt("${fld:num}");
}
</rows>
if( otherNum > 0 ){
	cardtypeCharts.seriesDataArr[cardtypeCharts.total] = otherNum;
	cardtypeCharts.legendData[cardtypeCharts.total] = "其他";
	cardtypelist[cardtypeCharts.total] = {value: otherNum, name: '其他'};
	cardtypeCharts.total++;
}

cardtypeCharts.seriesDataArrOther = [], cardtypeCharts.legendDataOther = [], idx = 0, otherCPNum = 0;
<tb-rows>
if(idx <= 4){
	cardtypeCharts.othertitlename = cardtypeCharts.titlename + "[同]";
	cardtypeCharts.seriesDataArrOther[idx] = parseInt("${fld:num}");
	cardtypeCharts.legendDataOther[idx] = "${fld:descr@js}";
	cardtypelist[cardtypelist.length] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
	idx++;
}else{
	otherCPNum += parseInt("${fld:num}");
}
</tb-rows>

<hb-rows>
if(idx <= 4){
	cardtypeCharts.othertitlename = cardtypeCharts.titlename + "[环]";
	cardtypeCharts.seriesDataArrOther[idx] = parseInt("${fld:num}");
	cardtypeCharts.legendDataOther[idx] = "${fld:descr@js}";
	cardtypelist[cardtypelist.length] = {value: parseInt("${fld:num}"), name: '${fld:descr@js}'};
	idx++;
}else{
	otherCPNum += parseInt("${fld:num}");
}
</hb-rows>
if( otherCPNum > 0 ){
	cardtypeCharts.seriesDataArrOther[cardtypeCharts.seriesDataArrOther.length] = otherCPNum;
	cardtypeCharts.legendDataOther[cardtypeCharts.legendDataOther.length] = "其他";
	cardtypelist[cardtypelist.length] = {value: otherCPNum, name: '其他'};
}

if( cardtypeCharts.total > 0 ){
	initPieCharts("cardtypeDiv", cardtypeCharts);
	//列表
	pielist("cardtype", cardtypelist);
}else{
	$("#cardtypeDiv,#cardtypeDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

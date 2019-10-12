/** 会籍漏斗 */
var guestnum = parseInt("${fld:guestnum}");
var visitnum = parseInt("${fld:visitnum}");
var expiredcardnum = parseInt("${fld:expiredcardnum}");//到期卡数量
var newcardnum = 0;
var cttncardnum = 0;
var custnum = parseInt("${fld:custnum}");

var xdataArr = [], idx = 0, newTrendArr = [], newTrendRate = 0;
<newcard-rows>
newcardnum += parseInt("${fld:num}");
newTrendRate = (0 == guestnum ? 0 : parseFloat("${fld:num}")*100.00/parseFloat(guestnum)).toFixed(0);
xdataArr[idx] = "${fld:createdate}";
newTrendArr[idx] = parseInt("${fld:num}");
idx++;
</newcard-rows>

var cttnTrendArr = [], cttnTrendRate = 0;
idx = 0;
<cttncard-rows>
cttncardnum += parseInt("${fld:num}");
cttnTrendRate = (0 == custnum ? 0 : parseFloat("${fld:num}")*100.00/parseFloat(custnum)).toFixed(0);
cttnTrendArr[idx] = cttnTrendRate;
idx++;
</cttncard-rows>

var totalnum = guestnum + visitnum + newcardnum + cttncardnum + expiredcardnum;
var guestRate = (0 == totalnum ? 0 : parseFloat(guestnum)*100.00/parseFloat(totalnum)).toFixed(0);
var visitRate = (0 == totalnum ? 0 : parseFloat(visitnum)*100.00/parseFloat(totalnum)).toFixed(0);
var newcardRate = (0 == totalnum ? 0 : parseFloat(newcardnum)*100.00/parseFloat(totalnum)).toFixed(0);
var cttncardRate = (0 == totalnum ? 0 : parseFloat(cttncardnum)*100.00/parseFloat(totalnum)).toFixed(0);
var expiredcardnumRate = (0 == totalnum ? 0 : parseFloat(expiredcardnum)*100.00/parseFloat(totalnum)).toFixed(0);
var funnelSeriesData = [
	{value: guestRate, name: "客户资源", num: guestnum},
	{value: visitRate, name: "资源到访", num: visitnum},
	{value: newcardRate, name: "办卡入会", num: newcardnum},
	{value: cttncardRate, name: "续会", num: cttncardnum},
	{value: expiredcardnumRate, name: "到期量", num: expiredcardnum}
];
mcFunnel.createCharts(funnelSeriesData);

/** 趋势 */
var trendLegendData = ["办卡入会","续会"];
var trendSeriesData = [
	{
		name: "办卡入会",
		type: "line",
		data: newTrendArr
	},
	{
		name: "续会",
		type: "line",
		data: cttnTrendArr
	}
];

if(xdataArr.length>0){
	mcTrend.createCharts(trendLegendData, xdataArr, trendSeriesData);
}else{
	$("#mcFunnelDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

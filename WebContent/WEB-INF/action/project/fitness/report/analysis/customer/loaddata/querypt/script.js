/** 私教漏斗 */
var guestnum = parseInt("${fld:guestnum}");
var newcardnum = parseInt("${fld:newcardnum}");
var newptnum = 0;
var cttnptnum = 0;
var custnum = parseInt("${fld:custnum}");

var xdataArr = [], idx = 0, newTrendArr = [], newTrendRate = 0;
var cttnTrendArr = [], cttnTrendRate = 0;
<pt-rows>
xdataArr[idx] = "${fld:createdate}";
newptnum += parseInt("${fld:num}");
newTrendRate = (0 == guestnum ? 0 : parseFloat("${fld:num}")*100.00/parseFloat(guestnum)).toFixed(2);
newTrendArr[idx] = newTrendRate;

cttnptnum += parseFloat("${fld:num1}");
cttnTrendRate = (0 == guestnum ? 0 : parseFloat("${fld:num1}")*100.00/parseFloat(guestnum)).toFixed(2);
cttnTrendArr[idx] = cttnTrendRate;
idx++;
</pt-rows>

var totalnum = guestnum + newcardnum + newptnum + cttnptnum;
var guestRate = (0 == totalnum ? 0 : parseFloat(guestnum)*100.00/parseFloat(totalnum)).toFixed(2);
var newcardRate = (0 == totalnum ? 0 : parseFloat(newcardnum)*100.00/parseFloat(totalnum)).toFixed(2);
var newptRate = (0 == totalnum ? 0 : parseFloat(newptnum)*100.00/parseFloat(totalnum)).toFixed(2);
var cttnptRate = (0 == totalnum ? 0 : parseFloat(cttnptnum)*100.00/parseFloat(totalnum)).toFixed(2);
var funnelSeriesData = [
	{value: guestRate, name: "会员量", num: custnum-guestnum},
	{value: newptRate, name: "购买私教", num: newptnum},
	{value: cttnptRate, name: "复购私教", num: cttnptnum}
];
ptFunnel.createCharts(funnelSeriesData);

/** 趋势 */
var trendLegendData = ["私教购买率","私教复购率"];
var trendSeriesData = [
	{
		name: "私教购买率",
		type: "line",
		data: newTrendArr
	},
	{
		name: "私教复购率",
		type: "line",
		data: cttnTrendArr
	}
];
if(xdataArr.length>0){
	ptTrend.createCharts(trendLegendData, xdataArr, trendSeriesData);
}else{
	$("#ptFunnelDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

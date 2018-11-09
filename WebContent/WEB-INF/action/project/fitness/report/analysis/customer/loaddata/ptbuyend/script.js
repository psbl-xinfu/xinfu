$("#ptbuyDiv").html("");
// 私教购买分析
var seriesArr = [
	{value: ${fld:inperformcust}, name: '在执行私教会员'},
	{value: ${fld:overduecust}, name: '私教过期会员', selected: true},
	{value: ${fld:nobuycust}, name: '未购私教会员'}
];
if(${fld:inperformcust}==0&&${fld:overduecust}==0&&${fld:nobuycust}==0){
	$("#ptbuyDiv,#ptbuyDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}else{
	ptbuyendPic.createCharts(seriesArr);
	//列表
	pielist("ptbuy", seriesArr);
}
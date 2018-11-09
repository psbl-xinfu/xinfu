$("#ptsalesamountDiv").html("");
var seriesArr = [];
//查询每个私教类型售金额,销售金额前五显示,其次合为其他
var count = 0, othernum=0;
<ptrestmoney-rows>
	if(count<7){
		seriesArr[count] = {value:"${fld:ptmoney}",name:"${fld:ptlevelname}"};
	}else{
		othernum += Number("${fld:ptmoney}");
	}
	count++;
</ptrestmoney-rows>
if(othernum>0)
	seriesArr[seriesArr.length++] = {value:othernum,name:"其他"};

if(seriesArr.length>0){
	ptsalesamountendPic.createCharts(seriesArr);
	//列表
	pielist("ptsalesamount", seriesArr);
}else{
	$("#ptsalesamountDiv,#ptsalesamountDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

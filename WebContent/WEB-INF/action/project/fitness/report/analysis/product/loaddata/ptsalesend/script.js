$("#ptsalesDiv").html("");
var seriesArr = [];
//查询每个私教类型售数量,销售量前五显示,其次合为其他
var count = 0, othernum=0;
<ptrestnum-rows>
	if(count<5){
		seriesArr[count] = {value:"${fld:num}",name:"${fld:ptlevelname}"};
	}else{
		othernum += parseInt("${fld:num}");
	}
	count++;
</ptrestnum-rows>
if(count>0)
	seriesArr[seriesArr.length++] = {value:othernum,name:"其他"};

if(seriesArr.length>0){
	ptsalesendPic.createCharts(seriesArr);
	//列表
	pielist("ptsales", seriesArr);
}else{
	$("#ptsalesDiv,#ptsalesDivlist").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

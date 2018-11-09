
/** 营收额饼图 **/
var seriesArr = [];
<rows>
seriesArr[seriesArr.length] = {name:"${fld:descr}",value:"${fld:fee}"};
</rows>

if( seriesArr.length > 0 ){
	revenuepiePic.createCharts(seriesArr);
}else{
	$("#revenuepieDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}
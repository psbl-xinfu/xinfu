
/** 销售金额 **/
var ptsales1 = [];

ptsales.total = 0;
ptsales.xdataArr = [], ptsales.seriesDataArr = [];
var arr = [];

<rows>
arr[arr.length] = {date:"${fld:createdate}",num1:"${fld:fee}"};
</rows>

for(var i in arr){
    if (arr.hasOwnProperty(i)) { //filter,只输出man的私有属性
    	ptsales.xdataArr[ptsales.total] = arr[i].date;
    	ptsales1[ptsales.total] = arr[i].num1;
		ptsales.total++;
    };
}
ptsales.seriesDataArr = [ptsales1];
if( ptsales.total > 0 ){
	initLineBarCharts("ptsalesamountDiv", ptsales);
}else{
	$("#ptsalesamountDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}
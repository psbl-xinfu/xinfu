
/** 销售金额 **/
var sales1 = [];

sales.total = 0;
sales.xdataArr = [], sales.seriesDataArr = [];
var arr = [];

<rows>
arr[arr.length] = {date:"${fld:createdate}",num1:"${fld:fee}"};
</rows>

for(var i in arr){
    if (arr.hasOwnProperty(i)) { //filter,只输出man的私有属性
    	sales.xdataArr[sales.total] = arr[i].date;
    	sales1[sales.total] = arr[i].num1;
		sales.total++;
    };
}
sales.seriesDataArr = [sales1];
if( sales.total > 0 ){
	initLineBarCharts("salesamountDiv", sales);
}else{
	$("#salesamountDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}
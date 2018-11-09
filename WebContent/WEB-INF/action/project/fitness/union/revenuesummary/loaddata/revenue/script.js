
/** 销售金额 **/
var revenue1 = [];

revenue.total = 0;
revenue.xdataArr = [], revenue.seriesDataArr = [];
var arr = [];
<rows>
arr[arr.length] = {date:"${fld:createdate}",num1:"${fld:fee}"};
</rows>

for(var i in arr){
    if (arr.hasOwnProperty(i)) { //filter,只输出man的私有属性
    	revenue.xdataArr[revenue.total] = arr[i].date;
    	revenue1[revenue.total] = arr[i].num1;
		revenue.total++;
    };
}
revenue.seriesDataArr = [revenue1];
if( revenue.total > 0 ){
	initLineBarCharts("revenuesummaryDiv", revenue);
}else{
	$("#revenuesummaryDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

/** 综合到访量 **/
var closing1 = [];
var closing2 = [];

closing.total = 0;
closing.xdataArr = [], closing.seriesDataArr = [];

var arr = [], idx = 0;
<rows>
arr[idx] = {date:"${fld:createdate}",num1:"${fld:num1}",num2:"${fld:num2}"};
idx++;
</rows>

for(var i in arr){
    if (arr.hasOwnProperty(i)) { //filter,只输出man的私有属性
    	closing.xdataArr[closing.total] = arr[i].date;
    	closing1[closing.total] = arr[i].num1;
    	closing2[closing.total] = arr[i].num2;
    	closing.total++;
    };
}
closing.seriesDataArr = [closing1,closing2];
if( closing.total > 0 ){
	initLineBarCharts("comprehensiveclosingDiv", closing);
}else{
	$("#comprehensiveclosingDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}
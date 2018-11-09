
/** 合同欠款 **/
var contract1 = [];

contract.total = 0;
contract.xdataArr = [], contract.seriesDataArr = [];
var arr = [], idx = 0;
<rows>
arr[idx] = {date:"${fld:createdate}",num1:"${fld:fee}"};
idx++;
</rows>

for(var i in arr){
    if (arr.hasOwnProperty(i)) { //filter,只输出man的私有属性
    	contract.xdataArr[contract.total] = arr[i].date;
    	contract1[contract.total] = arr[i].num1;
		contract.total++;
    };
}
contract.seriesDataArr = [contract1];
if( contract.total > 0 ){
	initLineBarCharts("contractbalanceDiv", contract);
}else{
	$("#contractbalanceDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}
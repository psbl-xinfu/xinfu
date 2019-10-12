
/** 访客来源 **/
var source1 = [],source2 = [], source3 = [];

source.total = 0;
source.xdataArr = [], source.seriesDataArr = [];
var arr = [{date:"${fld:fdate}",num1:"12",num2:"9",num3:"20"},
           	{date:"${fld:tdate}",num1:"28",num2:"10",num3:"28"}];
for(var i in arr){
    if (arr.hasOwnProperty(i)) { //filter,只输出man的私有属性
    	source.xdataArr[source.total] = arr[i].date;
    	source1[source.total] = arr[i].num1;
    	source2[source.total] = arr[i].num2;
    	source3[source.total] = arr[i].num3;
		source.total++;
    };
}
source.seriesDataArr = [source1, source2, source3];
if( source.total > 0 ){
	initLineBarCharts("sourcevisitorsDiv", source);
}
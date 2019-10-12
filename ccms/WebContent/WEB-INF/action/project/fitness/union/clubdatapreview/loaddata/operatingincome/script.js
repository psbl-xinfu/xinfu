
/** 每日营业收入 **/
var income1 = [];	/** 会员卡销售 */
var income2 = [];	/** 私教销售 */
var income3 = [];	/** 运营收入 */
var income4 = [];	/** 零售收入 */

income.total = 0;
income.xdataArr = [], income.seriesDataArr = [];
var arr = [], idx = 0;
<rows>
arr[idx] = {date:"${fld:createdate}",num1:"${fld:num1}",num2:"${fld:num2}",num3:"${fld:num3}",num4:"${fld:num4}"};
idx++;
</rows>

for(var i in arr){
    if (arr.hasOwnProperty(i)) { //filter,只输出man的私有属性
    	income.xdataArr[income.total] = arr[i].date;
    	income1[income.total] = arr[i].num1;
    	income2[income.total] = arr[i].num2;
    	income3[income.total] = arr[i].num3;
    	income4[income.total] = arr[i].num4;
		income.total++;
    };
}
income.seriesDataArr = [income1,income2,income3,income4];
if( income.total > 0 ){
	initLineBarCharts("operatingincomeDiv", income);
}else{
	$("#operatingincomeDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}
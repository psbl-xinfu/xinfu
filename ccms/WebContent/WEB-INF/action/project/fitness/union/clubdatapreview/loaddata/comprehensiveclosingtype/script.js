/** 综合成交率(POS、P1、P2) **/
var closingtype1 = [];
var closingtype2 = [];
var closingtype3 = [];

closingtype.total = 0;
closingtype.xdataArr = [], closingtype.seriesDataArr = [];

/** 综合成交率 */
var custNum = 0;	/** 成交总人数 */
var p1CustNum = 0;	/** P1成交人数 */
var p2CustNum = 0;	/** P2成交人数 */
var p1Num = 0;	/** P1人数 */
var p2Num = 0;	/** P2人数 */
var experNum = 0;	/** 体验课总人数 */
var compRate = 0;	/*** 综合成交率 = 成交总人数/体验课总人数 */
var p1Rate = 0;	/** P1成交率 = P1成交人数/P1人数 */
var p2Rate = 0;	/** P2成交率 = P2成交人数/P2人数 */
var arr = [], idx = 0;
<rows>
custNum = parseInt("${fld:cust_num}");
p1CustNum = parseInt("${fld:p1_cust_num}");
p2CustNum = parseInt("${fld:p2_cust_num}");
p1Num = parseInt("${fld:p1_num}");
p2Num = parseInt("${fld:p2_num}");
experNum = parseInt("${fld:exper_num}");
compRate = (parseFloat(custNum)*100.00/parseFloat(experNum == 0 ? 1 : experNum)).toFixed(0);
compRate = (compRate > 100 ? 100 : compRate);
p1Rate = (parseFloat(p1CustNum)*100.00/parseFloat(p1Num == 0 ? 1 : p1Num)).toFixed(0);
p1Rate = (p1Rate > 100 ? 100 : p1Rate);
p2Rate = (parseFloat(p2CustNum)*100.00/parseFloat(p2Num == 0 ? 1 : p2Num)).toFixed(0);
p2Rate = (p2Rate > 100 ? 100 : p2Rate);
arr[idx] = {date:"${fld:createdate}",num1: parseInt(compRate),num2: parseInt(p2Rate),num3: parseInt(p1Rate)};
idx++;
</rows>

<tb-rows></tb-rows>
<hb-rows></hb-rows>

for(var i in arr){
    if (arr.hasOwnProperty(i)) { //filter,只输出man的私有属性
    	closingtype.xdataArr[closingtype.total] = arr[i].date;
    	closingtype1[closingtype.total] = arr[i].num1;
    	closingtype2[closingtype.total] = arr[i].num2;
    	closingtype3[closingtype.total] = arr[i].num3;
		closingtype.total++;
    };
}
closingtype.seriesDataArr = [closingtype1,closingtype2,closingtype3];
if( closingtype.total > 0 ){
	initLineBarChartsPercentage("comprehensiveclosingtypeDiv", closingtype);
}else{
	$("#comprehensiveclosingtypeDiv").html("<img src='${def:context}/js/project/fitness/image/SVG/echarts/no_data.png' />");
}

/** POS */
var posnum = 0;
var custNum = 0;	/** 成交总人数 */
var p1CustNum = 0;	/** P1成交人数 */
var p2CustNum = 0;	/** P2成交人数 */
var p1Num = 0;	/** P1人数 */
var p2Num = 0;	/** P2人数 */
var experNum = 0;	/** 体验课总人数 */
var compRate = 0;	/*** 综合成交率 = 成交总人数/体验课总人数 */
var p1Rate = 0;	/** P1成交率 = P1成交人数/P1人数 */
var p2Rate = 0;	/** P2成交率 = P2成交人数/P2人数 */

var xdataArr = [], posArr = [], p1Arr = [], p2Arr = [];
<pos-rows>
xdataArr[posnum] = "${fld:createdate}";
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
posArr[posnum] = parseInt(compRate);
p1Arr[posnum] = parseInt(p1Rate);
p2Arr[posnum] = parseInt(p2Rate);
posnum++;
</pos-rows>

if( posnum > 0 ){
	initLineBarCharts("posDiv", xdataArr, posArr, p1Arr, p2Arr);
}

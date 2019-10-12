var targetpt = 0;	// 本月上课目标
var targetpttest = 0;	// 本月体验课目标
var targetcall = 0;	// 私教回访目标
var targetfee = 0;	// 目标金额
<target-rows>
	targetpt = parseInt("${fld:allclass_target}");
	targetpttest = parseInt("${fld:unpayclass_target}");
	targetcall = parseInt("${fld:call_pt_target}");
	targetfee = parseFloat("${fld:orderfee_target}");
</target-rows>
var monthpt = parseInt("${fld:monthpt}");	// 本月上课课时
var todaypt = parseInt("${fld:todaypt}");	// 今日上课课时
var monthpttest = parseInt("${fld:monthpttest}");	// 本月体验课课时
var guestnum = parseInt("${fld:guestnum}");	// 资源跟进数
var daycount = new Date().getDate();	// 本月天数
var targettodaypt = Math.ceil(parseFloat(targetpt)/parseFloat(daycount));	// 今日上课目标

// 本月销售业绩
var saletotalfee = parseFloat("${fld:saletotalfee}");
var saleRate = parseFloat(saletotalfee)/parseFloat(targetfee > 0 ? targetfee : 1);
saleRate = (saleRate > 1.00 ? 1.00 : saleRate).toFixed(2);
var liquidFillObj = new liquidFillCharts("ptsaleDiv");
liquidFillObj.updateOption([saleRate], saletotalfee);
$("#saleFee").text(saletotalfee);
$("#saleRate").text((parseFloat(saleRate)*100.00).toFixed(0)+"%");

// 本月上课课时
$("#monthFinishNum").text(monthpt);
var monthptRate = (parseFloat(monthpt)*100.00/parseFloat(targetpt > 0 ? targetpt : 1)).toFixed(0);
$("#monthFinishRate").text(monthptRate+"%");
$("#monthFinishRate").css("margin-left", getRateProgressMargin(monthptRate)+"%");
$("#monthFinishProgress").css("width", monthptRate+"%");
// 今日上课课时
$("#todayFinishNum").text(todaypt);
var todayptRate = (parseFloat(todaypt)*100.00/parseFloat(targettodaypt > 0 ? targettodaypt : 1)).toFixed(0);
$("#todayFinishRate").text(todayptRate+"%");
$("#todayFinishRate").css("margin-left", getRateProgressMargin(todayptRate)+"%");
$("#todayFinishProgress").css("width", todayptRate+"%");
// 体验课上课数量
$("#testFinishNum").text(monthpttest);
var testptRate = (parseFloat(monthpttest)*100.00/parseFloat(targetpttest > 0 ? targetpttest : 1)).toFixed(0);
$("#testFinishRate").text(testptRate+"%");
$("#testFinishRate").css("margin-left", getRateProgressMargin(testptRate)+"%");
$("#testFinishProgress").css("width", testptRate+"%");
// 资源
$("#guestNum").text(guestnum);
var guestRate = (parseFloat(guestnum)*100.00/parseFloat(targetcall > 0 ? targetcall : 1)).toFixed(0);
$("#guestRate").text(guestRate+"%");
$("#guestRate").css("margin-left", getRateProgressMargin(guestRate)+"%");
$("#guestProgress").css("width", guestRate+"%");

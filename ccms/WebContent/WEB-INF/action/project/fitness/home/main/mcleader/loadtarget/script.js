
var targetcall = 0, targetvisit = 0, targetfee = 0, ordernum_target = 0, guest_target= 0;	
<target-rows>
	//会籍回访目标
	targetcall = parseInt("${fld:call_mc_target}");
	//到访人数
	targetvisit = parseInt("${fld:visit_target}");
	//成单额
	targetfee = parseFloat("${fld:orderfee_target}");
	//成单量
	ordernum_target = parseInt("${fld:ordernum_target}");
	//资源获取量
	guest_target = parseInt("${fld:guest_target}");
</target-rows>

// 本月销售业绩
var saletotalfee = parseFloat("${fld:saletotalfee}");
var saleRate = parseFloat(saletotalfee)/parseFloat(targetfee > 0 ? targetfee : 1);
saleRate = (saleRate > 1.00 ? 1.00 : saleRate).toFixed(2);
var liquidFillObj = new liquidFillCharts("ptsaleDiv");
liquidFillObj.updateOption([saleRate], saletotalfee);
$("#saleFee").text(saletotalfee);
$("#saleRate").text((parseFloat(saleRate)*100.00).toFixed(0)+"%");

var guestnum = parseInt("${fld:guestnum}");	// 资源跟进数
// 待分配资源
$("#guestNum").text(guestnum);
var guestRate = (parseFloat(guestnum)*100.00/parseFloat(targetcall > 0 ? targetcall : 1)).toFixed(0);
$("#guestRate").text(guestRate+"%");
$("#guestRate").css("margin-left", getRateProgressMargin(guestRate)+"%");
$("#guestProgress").css("width", guestRate+"%");


var visitnum = parseInt("${fld:visitnum}");	// 到访人数
//到访人数
$("#visitnum").html(visitnum);
var visitnumRate = (parseInt(visitnum)*100.00/parseInt(targetvisit > 0 ? targetvisit : 1)).toFixed(0);
$("#visitnumRate").text(visitnumRate+"%");
$("#visitnumRate").css("margin-left", getRateProgressMargin(visitnumRate)+"%");
$("#visitnumProgress").css("width", visitnumRate+"%");

//新增会员
var newcustnum = parseInt("${fld:newcustnum}");	
$("#newcustnum").html(newcustnum);
var newcustnumRate = (parseInt(newcustnum)*100.00/parseInt(ordernum_target > 0 ? ordernum_target : 1)).toFixed(0);
$("#newcustnumRate").text(newcustnumRate+"%");
$("#newcustnumRate").css("margin-left", getRateProgressMargin(newcustnumRate)+"%");
$("#newcustnumProgress").css("width", newcustnumRate+"%");

//新增资源
var newguestnum = parseInt("${fld:newguestnum}");	
$("#newguestnum").html(newguestnum);
var newguestnumRate = (parseInt(newguestnum)*100.00/parseInt(guest_target > 0 ? guest_target : 1)).toFixed(0);
$("#newguestnumRate").text(newguestnum+"%");
$("#newguestnumRate").css("margin-left", getRateProgressMargin(newguestnumRate)+"%");
$("#newguestnumProgress").css("width", newguestnumRate+"%");


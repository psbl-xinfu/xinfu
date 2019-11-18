
var targetfee = 0;	
<target-rows>
	//成单额
	targetfee = parseFloat("${fld:orderfee_target}");
</target-rows>

// 本月销售业绩
var saletotalfee = parseFloat("${fld:saletotalfee}").toFixed("2");
var saleRate = parseFloat(saletotalfee)/parseFloat(targetfee > 0 ? targetfee : 1);
saleRate = (saleRate > 1.00 ? 1.00 : saleRate).toFixed(2);
var liquidFillObj = new liquidFillCharts("mcsaleDiv");
liquidFillObj.updateOption([saleRate], saletotalfee);
$("#mcsaleFee").text(saletotalfee);
$("#mcsaleRate").text((parseFloat(saleRate)*100.00).toFixed(0)+"%");



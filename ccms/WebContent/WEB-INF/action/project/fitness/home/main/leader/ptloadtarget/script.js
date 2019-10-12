var targetfee = 0;	// 目标金额
<target-rows>
	targetfee = parseFloat("${fld:orderfee_target}");
</target-rows>

// 本月销售业绩
var saletotalfee = parseFloat("${fld:saletotalfee}").toFixed("2");
var saleRate = parseFloat(saletotalfee)/parseFloat(targetfee > 0 ? targetfee : 1);
saleRate = (saleRate > 1.00 ? 1.00 : saleRate).toFixed(2);
var liquidFillObj = new liquidFillCharts("ptsaleDiv");
liquidFillObj.updateOption([saleRate], saletotalfee);
$("#ptsaleFee").text(saletotalfee);
$("#ptsaleRate").text((parseFloat(saleRate)*100.00).toFixed(0)+"%");


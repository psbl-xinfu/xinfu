var call_target = 0;	// 设定本月回访量
<target-rows>
call_target = parseInt("${fld:call_target}");
</target-rows>

// 本月回访
var reception = parseFloat("${fld:num}");
var receptionRate = parseFloat(reception)/parseFloat(call_target > 0 ? call_target : 1);
receptionRate = (receptionRate > 1.00 ? 1.00 : receptionRate).toFixed(2);
var liquidFillObj = new liquidFillCharts("receptionDiv");
liquidFillObj.updateOption([receptionRate], reception);
$("#receptionFee").text(reception);
$("#receptionRate").text((parseFloat(receptionRate)*100.00).toFixed(0)+"%");


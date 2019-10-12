
var normalmoney = Number("${fld:normalmoney}");//应收
var factmoney = Number("${fld:factmoney}");//实收
var contracttype = "${fld:contracttype}";
var url = "";
if(contracttype=="0"&&normalmoney==factmoney){
	//普通续卡合同
	url = "${def:context}/action/project/fitness/print/contract/cardcontract_xuka?pk_value=${fld:code}";
}else if(contracttype=="0"&&normalmoney!=factmoney){
	//续卡定金合同
	url = "${def:context}/action/project/fitness/print/contract/cardcontract_xuka_dingjing?pk_value=${fld:code}";
}else{
	//续卡还款合同
	url = "${def:context}/action/project/fitness/print/contract/cardcontract_xuka_repay?pk_value=${fld:code}";
}
ajaxCall(url,{
	method: "get",
	progress: true,
	dataType: "script",
	success: function() {
	}
});



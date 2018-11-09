
var normalmoney = Number("${fld:normalmoney}");//应收
var factmoney = Number("${fld:factmoney}");//实收
var contracttype = "${fld:contracttype}";
var url = "";
if(contracttype=="0"&&normalmoney==factmoney){
	//普通私教合同
	url = "${def:context}/action/project/fitness/print/contract/ptcontract?pk_value=${fld:code}";
}else if(contracttype=="0"&&normalmoney!=factmoney){
	//私教定金合同
	url = "${def:context}/action/project/fitness/print/contract/ptcontract_dingjin?pk_value=${fld:code}";
}else{
	//私教还款合同
	url = "${def:context}/action/project/fitness/print/contract/ptcontract_repay?pk_value=${fld:code}";
}
ajaxCall(url,{
	method: "get",
	progress: true,
	dataType: "script",
	success: function() {
	}
});



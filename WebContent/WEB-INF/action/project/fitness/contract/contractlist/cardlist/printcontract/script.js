
<row>
var normalmoney = Number("${fld:normalmoney}");//应收
var factmoney = Number("${fld:factmoney}");//实收
var contracttype = "${fld:contracttype}";
var url = "";
//type等于1计次卡
if("${fld:type}"=="1"){
	if(contracttype=="0"&&normalmoney==factmoney){
		//次卡普通办卡合同
		url = "${def:context}/action/project/fitness/print/contract/cardcontract_count?pk_value=${fld:code}";
	}else if(contracttype=="0"&&normalmoney!=factmoney){
		//办卡定金合同
		url = "${def:context}/action/project/fitness/print/contract/cardcountcontractdingjin?pk_value=${fld:code}";
	}else{
		//办卡还款合同
		url = "${def:context}/action/project/fitness/print/contract/cardcountcontractrepay?pk_value=${fld:code}";
	}
}else{
	if(contracttype=="0"&&normalmoney==factmoney){
		//普通办卡合同
		url = "${def:context}/action/project/fitness/print/contract/cardcontract?pk_value=${fld:code}";
	}else if(contracttype=="0"&&normalmoney!=factmoney){
		//办卡定金合同
		url = "${def:context}/action/project/fitness/print/contract/cardcontract_dingjin?pk_value=${fld:code}";
	}else{
		//办卡还款合同
		url = "${def:context}/action/project/fitness/print/contract/cardcontract_repay?pk_value=${fld:code}";
	}
}
ajaxCall(url,{
	method: "get",
	progress: true,
	dataType: "script",
	success: function() {
	}
});
</row>



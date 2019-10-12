var ctcode = "", custcode = "", status = 0, contracttype = 0, ctype = 0, stage_times = 1, normalmoney = 0.0, factmoney = 0.0, repaystatus = 0;
<rows>
	ctcode = "${fld:code}";
	custcode = "${fld:customercode}";
	status = parseInt("${fld:status}");
	contracttype = parseInt("${fld:contracttype}");
	ctype = parseInt("${fld:type}");
	stage_times = parseInt("${fld:stage_times}");
	normalmoney = parseFloat("${fld:normalmoney}");
	factmoney = parseFloat("${fld:factmoney}");
	repaystatus = parseInt("${fld:repaystatus}");
</rows>

if( "" == ctcode ){
	ccms.dialog.alert("不存在该合同或该合同无效！");
}else if( status == 1 ){
	ccms.dialog.alert("请先完成本合同付款后再操作！");
}else if( normalmoney == factmoney || contracttype == 3 || repaystatus >= 2 ){
	ccms.dialog.alert("当前合同无欠款！");
}else if( repaystatus == 1 ){
	ccms.dialog.alert("已产生还款合同且未付款，不能重复产生还款合同！");
}else{
	var uri = contextPath + getContractUri(3, ctype, false);
	uri += "?relatecode=" + ctcode;
	ccms.dialog.open({url : uri});
}

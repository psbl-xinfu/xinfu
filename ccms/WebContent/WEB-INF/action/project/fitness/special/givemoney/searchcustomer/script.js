var count = 0;
<rows>
	document.formEditor.cust_name.value="${fld:name@js}";
	document.formEditor.customercode.value="${fld:code@js}";
	document.formEditor.mobile.value="${fld:mobile@js}";
	document.formEditor.moneycash.value="${fld:moneycash}";
	document.formEditor.moneygift.value="${fld:moneygift}";
	$("#existmoney").html("现有储值金额：${fld:moneycash}	运动基金：${fld:moneygift}");
	count++;
</rows>
if(count==0){
	ccms.dialog.alert("未查询到该会员！");
	$("#existmoney").html("");
	$("#cust_name,#customercode,#mobile,#moneycash,#moneygift").val("");
}

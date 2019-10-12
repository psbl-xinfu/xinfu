var count = 0;
<rows>
	document.formEditor.cust_name.value="${fld:name@js}";
	document.formEditor.customercode.value="${fld:code@js}";
	document.formEditor.mobile.value="${fld:mobile@js}";
	count++;
</rows>
if(count==0){
	ccms.dialog.alert("未查询到该会员！");
	$("#cust_name,#customercode,#mobile").val("");
}

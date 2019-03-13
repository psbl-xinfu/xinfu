var count = 0;
<rows>
	document.formEditor.cust_name.value="${fld:name@js}";
	document.formEditor.customercode.value="${fld:code@js}";
	document.formEditor.mobile.value="${fld:mobile@js}";
	count++;
</rows>
//bootstrap-select

//var s= $('#pt').selectpicker('val');//获取val值
document.getElementById("pt").options.selectedIndex = 0;//重置值
$("#pt").selectpicker("refresh");//刷新
document.getElementById("defcode").options.selectedIndex = 0;
$("#defcode").empty();
var str = "<option value=''>请选择</option>";
$("#defcode").html(str);
$("#defcode").selectpicker("refresh");//刷新
if($("#cust").val()!=""){
//	$("#pt").removeAttr("disabled"); 
	$(".selectpt").removeAttr("disabled");
	$(".selectpt").removeClass("disabled");
	$("[data-id|='pt']").removeClass("disabled");
}
	
if(count==0){
	ccms.dialog.alert("未查询到该会员！");
	$("#cust_name,#customercode,#mobile").val("");
}

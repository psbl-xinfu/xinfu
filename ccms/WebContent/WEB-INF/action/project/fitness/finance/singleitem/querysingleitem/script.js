<rows>
$("#item_insert").val("${fld:itemcode}");
$("#vc_code").val("${fld:code}");
$("#f_price").val("${fld:price}");
$("#vc_unit").val("${fld:unit}");
$("#f_amount").val(parseInt("${fld:amount}"));
$("#salename_insert").val("${fld:seller}");
$("#vc_rebate").val("${fld:zk}");
$("#f_money").val("${fld:money}");
$("#f_normalmoney").val("${fld:normalmoney}");
if("${fld:status}"=="2"){
	$("#consumptionpay,#i_paytypeone,#i_paytypethree").hide();
	$("#i_paytypefour").show();
	$("#zffs").html("${fld:zffs}");
}
$("#typetrhee").parent().hide();
$("#vc_rebate,#f_amount").attr("readonly", true);
$("#remark").val("${fld:remark}");
</rows>


$("#item_insert,#salename_insert").selectpicker("refresh");
$("#item_insert,#salename_insert").selectpicker("render");
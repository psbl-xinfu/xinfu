
var count = 0;
<rows>
	count++;
	$("#mobile").val("${fld:mobile}");
	$("#custname").val("${fld:name}");
	$("#moneygift").val("${fld:moneygift}");
	$("#moneycash").val("${fld:moneycash}");
	$("#custcode").val("${fld:code}");
	$("#drinkdiscount").val(("0" == Number("${fld:drinkdiscount}") ? "1" : Number("${fld:drinkdiscount}")));
</rows>
if(count==0){
	$("#cardcode").val("");
	ccms.dialog.notice("未查询到该会员！", 2000);
}
//重新计算
calculate();
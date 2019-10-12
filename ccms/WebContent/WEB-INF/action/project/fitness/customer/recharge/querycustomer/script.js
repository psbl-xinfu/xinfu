var count = 0;
<rows>
$("#name").val("${fld:name@js}");
$("#cust_code").val("${fld:code@js}");
$("#czmoeny").html("${fld:moneycash}");
$("#ydmoeny").html("${fld:moneygift}");
$("#enddate").html("${fld:enddate}");
count++;
</rows>
if(count==0){
	$("#name,#code").val("");
	$("#czmoeny,#enddate,#ydmoeny").html("");
	ccms.dialog.alert("没有该会员！");
}
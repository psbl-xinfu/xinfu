
var count = 0;
<rows>
	count++;
	$("#custname").html("${fld:name@js}");
	$("#sex").html("${fld:sex@js}");
	$("#mobile").html("${fld:mobile@js}");
	$("#cust_code").val("${fld:code@js}");

	if( "" != "${fld:imgid}" ){
		$("#headpic").attr("src", contextPath+"/action/project/fitness/util/attachment/download?tuid=${fld:imgid}&type=1");
	}else{
		$("#headpic").attr("src", contextPath+"/js/project/fitness/image/SVG/170X220.svg");
	}
</rows>
if(count==0){
	ccms.dialog.alert("没有该会员！");
}else{
	var url="${def:context}/action/project/fitness/customer/brushclass/searchptprepare?customercode="+$("#cust_code").val();
	ajaxCall(url,{
		method:"GET",
		progress:true,
		dataType:"script",
		success:function(){
		}
	});
}
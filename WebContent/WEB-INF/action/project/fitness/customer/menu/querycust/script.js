var a=0;
<row>
a++;
$("#vc_code").val("${fld:vc_customercode@js}");
</row>
if(a==0){
	$("#vc_code").val('');
}
$("#basicInfor").click();

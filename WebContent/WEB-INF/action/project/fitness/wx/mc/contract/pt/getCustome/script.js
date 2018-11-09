var flag=true;
<remmend>
flag=false;
$('#recommend').val("${fld:name}");
</remmend>
if(flag){
	ccms.dialog.notice("没有此人！",300,function(){
		$('#recommend').val("");
	});
}
var count = 0;
<rows>
	count++;
	var url="${def:context}${def:actionroot}/updateshoworder?tuid=${fld:tuid}"
		+"&showorder=${fld:showorder}&exchange_tuid=${fld:exchange_tuid}&exchange_showorder=${fld:exchange_showorder}";
	ajaxCall(url,{
		method:"GET",
		progress:true,
		dataType:"script",
		success:function(){
		}
	});
</rows>
if(count==0){
	ccms.dialog.alert("该科目显示循序已为最低！");
}



//预约时间加基础设置时间
var preparedate = new Date("${fld:preparedate}"); 
var time = preparedate.getTime() - Number("${fld:cancelbooktime}")*60*60*1000;
if(new Date(time)>=new Date()){
	$Dialog().confirm("确定要取消该预约吗?", function(){
		var uri="${def:actionroot}/quxiao?id=${fld:id}";
		ajaxCall(uri,{
			method: "get",
			progress: true,
			dataType: "script",
			success: function() {
			}
		});
	});
}else{
	ccms.dialog.notice("该预约应"+new Date(time).format("yyyy-MM-dd hh:mm")+"前取消，现已超时不能取消！", 4000);
}


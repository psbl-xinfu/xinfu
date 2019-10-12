ccms.dialog.notice("成功！", 2000, function(){
	if("${fld:othertype}" == null ){
		if("${fld:roodsreceipts}"=="1"){
			var uri="${def:context}/action/project/fitness/print/ticket/shoptickettt?pk_value=${fld:leave_stockid}";
			ajaxCall(uri,{
				method: "get",
				progress: true,
				dataType: "script",
				success: function() {
					location.href=location.href;
				}
			});
		}else{
			location.href=location.href;
		}
	}else{
		location.href=location.href;
	}
});
ccms.dialog.notice("成功！", 2000, function(){
	var uri="${def:context}/action/project/fitness/print/ticket/shoptickettt?pk_value=${fld:tuid}";
	ajaxCall(uri,{
		method: "get",
		progress: true,
		dataType: "script",
		success: function() {
			parent.search.searchData(1);
			ccms.dialog.close();
		}
	});
});
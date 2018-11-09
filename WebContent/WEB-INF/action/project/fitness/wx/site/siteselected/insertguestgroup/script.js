
ajaxCall("${def:actionroot}/queryguestgroup?weixin_userid=${fld:weixin_userid}"
		+"&tuid=${fld:tuid}&org_id=${fld:org_id}",{
	method:"get",
	dataType:"script",
	success:function(){
	}
});


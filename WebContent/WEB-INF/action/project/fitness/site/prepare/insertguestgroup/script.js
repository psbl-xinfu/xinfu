
ajaxCall("${def:actionroot}/queryguestgroup?pkvalue=${fld:pkvalue}"
		+"&tuid=${fld:tuid}&customertype=${fld:customertype}",{
	method:"get",
	dataType:"script",
	success:function(){
	}
});
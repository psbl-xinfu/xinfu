

$("#noticetitle").html("${fld:title}");
$("#noticecontent").html("${fld:content}");
$("#noticedate").html("${fld:created}");
$(".gg-mask,.gg-notice-dlg").show();

var url="${def:actionroot}/insert?tuid=${fld:tuid}&type=${fld:type}";
ajaxCall(url,{
	method:"get",
	progress:true,
	dataType:"script",
	success:function(){
	}
});

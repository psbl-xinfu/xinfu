if( "" != "#${fld:objid}" && $("#${fld:objid}") ){
	var obj = $("#${fld:objid}");
	<rows>
		if( "" != "${fld:headpic}"&&null != "${fld:headpic}" ){
			obj.attr("src", "${def:context}/${fld:headpic}");
		}else{
			obj.attr("src", "${def:context}/images/icon_head.png");
		}
	</rows>
}
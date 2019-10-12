

$("#xiaozu").val("${fld:groupname@js}");

$("#membernum").html("(${fld:num}/30人)");



$("#qzimg").html("<img src='"+contextPath + "/action/project/fitness/util/attachment/download?tuid=${fld:imgid}&type=1'"
				+" onerror=javascript:this.src='${def:context}/js/project/fitness/image/SVG/50X50.svg' /><");
$("#qzname").html("${fld:name}");

$("#gremark").html("${fld:remark}");


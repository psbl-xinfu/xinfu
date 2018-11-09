
var str = "";
<rows>
	str+="<div class='my_team' style='clear:both;' onclick='detail(${fld:tuid}, ${fld:org_id})'><div class='wrap lt'>";
	//等于1当前人是群主
	if("{fld:isadmin}"=="1")
		str+="<span class='admin'><img src='${def:context}/js/project/fitness/wx/image/team/admin.png' /></span>";
            
	ajaxCall("${def:actionroot}/querymember?groupid=${fld:tuid}&org_id=${fld:org_id}",{
		method:"get",
		dataType:"json",
		async:false,
		success:function(data){
			var arr = data.imgid.split(";");
			for (var i = 0; i < arr.length; i++) {
				str+="<div><img src='"+contextPath + "/action/project/fitness/util/attachment/download?tuid="+arr[i]+"&type=1'"
				+" onerror=javascript:this.src='${def:context}/js/project/fitness/image/SVG/50X50.svg' /></div>";
			}
		}
	});
	str+="</div><div class='rt m_team_content'><div class='team_name'>${fld:groupname}</div>"
		+"<div class='rt team_num'>(<span>${fld:num}</span>/30)</div><div class='jiyu'>${fld:remark@js}</div>"
		+"<div class='bao' style='";
	if("${fld:notice@js}"==""){
		str+="display:none;";
	}
	str+="'><i><img src='${def:context}/js/project/fitness/wx/image/team/bao.png' /></i>"
		+"<span>${fld:notice@js}</span></div></div></div>";

</rows>
$("#guestgroup").html(str);

var wrap_lenth = $('.wrap div').length;

if (wrap_lenth < 2) {
    $('.wrap div').addClass('c');
} else if (wrap_lenth < 5) {
    $('.wrap div').addClass('b');
} else {
    $('.wrap div').addClass('a');
}

function detail(tuid, org_id){
    location.href="${def:context}/action/project/fitness/wx/team/teamdetail/crud?groupid="
    	+tuid+"&org_id="+org_id+"&weixin_userid=${fld:weixin_userid}";
}


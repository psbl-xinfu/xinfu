
var orgstr = "";
<rows>
	orgstr+="<li onclick=detail('${fld:org_id}')><div class='list_con_left'>"
                 +"<img src='${def:context}/action/project/fitness/util/attachment/download?tuid=${fld:imgid}&type=1'"
                 +" onerror=\"this.src='${def:context}/js/project/fitness/wx/image/wx_site/chang.png'\" alt=''></div>"
                 +"<div class='list_con_right'><p class='cont_rt_tit'>${fld:org_name@js}</p>"
                 +"<div class='adress'><i><img src='${def:context}/js/project/fitness/wx/image/wx_site/adress.png' alt=''></i>"
                 +"<span>${fld:address@js}</span></div><div class='type'>"
                 +"<i><img src='${def:context}/js/project/fitness/wx/image/wx_site/type.png' alt=''></i><span>";
	var sitetype = "${fld:sitetype}".split("；");
	for(var i = 0;i<sitetype.length;i++){
		orgstr+=sitetype[i]+"&nbsp;&nbsp;&nbsp;&nbsp;";
	}
	orgstr+="</span></div></div></li>";
</rows>
$("#orglist").html(orgstr);


//门店详情
function detail(org_id){
	location.href="${def:context}/action/project/fitness/wx/site/sitelist/detail/crud?org_id="+org_id+"&weixin_userid=${fld:weixin_userid}";
}

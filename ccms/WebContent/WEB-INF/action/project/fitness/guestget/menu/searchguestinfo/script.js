
var gueststr = "";
<guest-rows>
	var sextype = "", intentioncolor = "", intentionstr = "";
	if("${fld:sex}"=="1"){
		sextype = "icon-man";
	}else if("${fld:sex}"=="0"){
		sextype = "icon-woman";
	}
	if("${fld:intention}"=="1"){
		intentioncolor = "red";
		intentionstr = "高关注";
	}else if("${fld:intention}"=="2"){
		intentioncolor = "orange";
		intentionstr = "普通";
	}else if("${fld:intention}"=="3"){
		intentioncolor = "green";
		intentionstr = "不关注";
	} 
	gueststr+="<li onclick=guestdetail('${fld:tuid}')><div class='u-item-left'>"
		+"<p><span class='nickname'>${fld:name}</span><span class='"+sextype+"'></span><span class='age'>${fld:age}</span></p>"
		+"<p class='tel'>${fld:mobile}</p></div><div class='u-item-right'><p class='purpose "+intentioncolor+"'>意向："+intentionstr+"</p>"
		+"<span class='icon-more'></span></div></li>";
</guest-rows>
$("#guestinfos").html(gueststr);
var hei=$('#guestinfos').find('li').first().height()
var len=$('#guestinfos').find('li').length
$("#guestinfos").height(hei*len+58)

//详情
function guestdetail(tuid){
    location.href = contextPath+"/action/project/fitness/guestget/index/add?tuid="+tuid;
}
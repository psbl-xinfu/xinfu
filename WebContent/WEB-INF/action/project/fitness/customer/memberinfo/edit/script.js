document.addForm.cc_code.value="${fld:code@js}";
document.addForm.cc_name.value="${fld:name@js}";
document.addForm.cc_mobile.value="${fld:mobile@js}"; 
setSelectValue($("#cc_birth"), "${fld:birth}");
setSelectValue($("#cc_day"), "${fld:birthday}");
setSelectValue($("#cc_sex"), "${fld:sex}");
var ymobile="${fld:mobile@js}";
 $("#userlogin").val("${fld:userlogin}");
 $("#user_id").val("${fld:user_id}");
setSelectValue($("#cc_mc"), "${fld:mc}");
setSelectValue($("#cc_type"), "${fld:type}");
document.addForm.cc_card.value="${fld:card}";
setSelectValue($("#cc_cardtype"), "${fld:cardtype}");
setSelectValue($("#cc_purpose"), "${fld:aim}");

setSelectValue($("#cc_nationality"), "${fld:nationality}");
setSelectValue($("#cc_nation"), "${fld:nation}");
document.addForm.cc_occupation.value="${fld:occupation}";
document.addForm.cc_email.value="${fld:email@js}";
document.addForm.province.value="${fld:province}";
 init_event_city = "${fld:city}";
$("#province").change();
document.addForm.cc_addr.value="${fld:addr@js}"; 

document.addForm.cc_officename.value="${fld:officename@js}";
document.addForm.cc_officetel.value="${fld:officetel@js}";
document.addForm.province2.value="${fld:province2}";
 init_event_city2 = "${fld:city2}";
$("#province2").change();
document.addForm.cc_officeaddr.value="${fld:officeaddr@js}"; 

document.addForm.cc_urgent.value="${fld:urgent}";
document.addForm.cc_othertel.value="${fld:othertel@js}";
setSelectValue($("#cc_leave"), "${fld:leave}");
setSelectValue($("#cc_gethobbit"), "${fld:gethobbit}");

setSelectValue($("#cc_marriage"), "${fld:marriage}");
setSelectValue($("#cc_children"), "${fld:children}");
document.addForm.cc_remark.value="${fld:remark@js}";
setSelectValue($("#cc_personalhobbit"), "${fld:personalhobbit}");
document.addForm.recommend.value="${fld:recommend_name}"; 
setSelectValue($("#cc_age"), "${fld:age}");
document.addForm.cc_wx.value="${fld:wx@js}"; 
document.addForm.cc_qq.value="${fld:qq}"; 

if( "" != "${fld:imgid}" ){
	$("#headpic").attr("src", contextPath+"/action/project/fitness/util/attachment/download?tuid=${fld:imgid}&type=1");
}else{
	$("#headpic").attr("src", contextPath+"/js/project/fitness/image/SVG/170X220.svg");
}

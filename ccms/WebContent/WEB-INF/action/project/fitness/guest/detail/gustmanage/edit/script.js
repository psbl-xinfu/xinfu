document.addForm.cus_code.value="${fld:recommend}";
document.addForm.in_recommend_name.value="${fld:recommend_name}";
document.addForm.cc_code.value="${fld:code@js}";
document.addForm.cc_name.value="${fld:name@js}";
setSelectValue($("#cc_sex"), "${fld:sex}");
document.addForm.cc_mobile.value="${fld:mobile@js}"; 
setSelectValue($("#cc_birth"), "${fld:birth}");
setSelectValue($("#cc_day"), "${fld:birthday}");
document.addForm.cc_wx.value="${fld:wx@js}";
document.addForm.cc_qq.value="${fld:qq}";
setSelectValue($("#cc_mc"), "${fld:mc}");
setSelectValue($("#cc_type"), "${fld:type}");
document.addForm.cc_card.value="${fld:card}";
setSelectValue($("#cc_cardtype"), "${fld:cardtype}");
setSelectValue($("#cc_level"), "${fld:level}");
setSelectValue($("#cc_nationality"), "${fld:nationality}");
setSelectValue($("#cc_nation"), "${fld:nation}");
document.addForm.cc_occupation.value="${fld:occupation@js}";
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
document.addForm.cc_officeaddr.value="${fld:officeaddr}"; 

document.addForm.cc_urgent.value="${fld:urgent@js}";
document.addForm.cc_othertel.value="${fld:othertel@js}";
setSelectValue($("#cc_purpose"), "${fld:purpose}");
setSelectValue($("#cc_participate"), "${fld:participate}");
document.addForm.cc_brand.value="${fld:brand}"; 
setSelectValue($("#cc_ismember"), "${fld:ismember}");
setSelectValue($("#cc_leave"), "${fld:leave}");
setSelectValue($("#cc_customtype"), "${fld:customtype}");
setSelectValue($("#cc_gethobbit"), "${fld:gethobbit}");
setSelectValue($("#cc_personalhobbit"), "${fld:personalhobbit}");

setSelectValue($("#cc_marriage"), "${fld:marriage}");
setSelectValue($("#cc_children"), "${fld:children}");
document.addForm.cc_remark.value="${fld:remark@js}";
document.addForm.cc_personalhobbit.value="${fld:personalhobbit}"; 
document.addForm.recommend.value="${fld:recommend_name}"; 
setSelectValue($("#cc_age"), "${fld:age}");

if( "" != "${fld:imgid}" ){
	$("#headpic").attr("src", contextPath+"/action/project/fitness/util/attachment/download?tuid=${fld:imgid}&type=1");
}else{
	$("#headpic").attr("src", contextPath+"/js/project/fitness/image/SVG/170X220.svg");
}

<edit-list>
document.formEditor.vc_code.value = "${fld:code@js}";
document.formEditor.camp_name.value = "${fld:campaign_name@js}";
document.formEditor.startdate.value = "${fld:startdate@yyyy-MM-dd}";
document.formEditor.enddate.value = "${fld:enddate@yyyy-MM-dd}";
document.formEditor.discount.value = "${fld:discount}";
setSelectValue($("#vc_cardtype"), "${fld:cardtype}");
document.formEditor.vc_remark.value = "${fld:remark@js}";
</edit-list>
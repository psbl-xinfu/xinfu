document.searchForm.vc_code.value = "${fld:code@js}";
document.searchForm.vc_name.value = "${fld:name@js}";
document.searchForm.i_membercount.value = "${fld:membercount}";
document.searchForm.i_type.value = "${fld:type}";
document.searchForm.vc_isoffseason.value = "${fld:isoffseason@js}";
ccms.util.setMulitCheckboxValue('vc_item',"${fld:item@js}","searchForm");
document.searchForm.i_daycount.value = "${fld:daycount}";
document.searchForm.i_allowcount.value = "${fld:allowcount}";
document.searchForm.f_limitswimtime.value = "${fld:limitswimtime}";
document.searchForm.i_freebathcount.value = "${fld:freebathcount}";
document.searchForm.f_scale.value = "${fld:scale}";
document.searchForm.i_giveday.value = "${fld:giveday}";
document.searchForm.i_ptcount.value = "${fld:ptcount}";
document.searchForm.vc_name.value = "${fld:name@js}";
document.searchForm.i_savedaycount.value = "${fld:savedaycount}";
document.searchForm.i_status.value = "${fld:status}";
document.searchForm.vc_remark.value = "${fld:remark@js}";
document.searchForm.i_count.value = "${fld:count}";
document.searchForm.f_cardfee.value = "${fld:f_cardfee@js}";
document.searchForm.f_moneyleft.value = "${fld:moneyleft}";

setisoffseason( "${fld:isoffseason@js}");
//${fld:i_universal}
setitem("${fld:item@js}","${fld:allowcount}", "","${fld:type}");
leixing("${fld:type}");
huixian("${fld:item@js}","${fld:type}");
huixian2();

$(".check").attr('disabled',true);
$("#vc_isoffseason").attr('disabled',true);
parent.$("#vc_name1").attr('disabled',true);
$("#i_type").attr('disabled',true);
$("#i_universal").attr('disabled',true);
parent.$("#i_membercount").attr('disabled',true);
parent.$("#i_allowcount").attr('disabled',true);

$("#f_limitswimtime").attr('readonly',true);
$("#i_freebathcount").attr('readonly',true);

$("#vc_remark").attr('readonly',true);
$("#i_ptcount").attr('readonly',true);
$("#i_savedaycount").attr('readonly',true);
$("#i_giveday").attr('readonly',true);
$("#f_scale").attr('readonly',true);
$("#f_cardfee").attr('readonly',true);
$("#f_moneyleft").attr('readonly',true);
parent.$("#vc_code").attr('readonly',true);
$("#vc_name").attr('readonly',true);
$("#i_daycount").attr('readonly',true);
$("#i_count").attr('readonly',true);

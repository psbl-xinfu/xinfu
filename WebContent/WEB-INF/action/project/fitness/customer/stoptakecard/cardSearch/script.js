<search-list>
document.formEditor.vvc_code.value ="${fld:vc_code}";
document.formEditor.vc_type.value ="${fld:vc_type}";
document.formEditor.xvc_name.value ="${fld:vc_name}";
document.formEditor.vc_customercode.value = "${fld:customercode}";
document.formEditor.cardname.value = "${fld:vc_cardcode}";
document.formEditor.vvc_cardcode.value = "${fld:vc_cardcode}";
document.formEditor.vc_cardtype.value = "${fld:vc_cardtype}";
document.formEditor.c_cardstartdate.value = "${fld:c_cardstartdate}";
document.formEditor.c_cardenddate.value = "${fld:c_cardenddate}";
document.formEditor.xc_startdate.value = "${fld:xc_startdate}";
document.formEditor.i_prestopdays.value = "${fld:i_prestopdays}";
document.formEditor.f_money.value = "${fld:f_money}";
document.formEditor.vc_reason.value = "${fld:vc_reason@js}";
document.formEditor.vc_remark.value = "${fld:vc_remark@js}";
document.formEditor.xsavestop_type.value = "${fld:savestop_type}";
document.formEditor.xi_status.value = "${fld:i_status}";
document.formEditor.stopCardDays.value ="${fld:stopcarddays}";
document.formEditor.i_actualdays.value ="${fld:stopcarddays}";
document.formEditor.daysremain.value ="${fld:daysremain}";
document.formEditor.ci_status.value ="${fld:ci_status}";
document.formEditor.vc_club.value ="${fld:vc_club}";
document.formEditor.ii_prestopdays.value ="${fld:i_prestopdays}"/30;
</search-list>

<saves-list>
$('#total_stopday').val("${fld:total_stopday}");
</saves-list>

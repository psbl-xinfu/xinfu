var b;
<rows>
document.formEditor.vc_code.value = "${fld:vc_code@js}";
document.formEditor.vc_name.value = "${fld:vc_name@js}";
document.formEditor.c_enddate.value = "${fld:c_enddate}";
if( "1" == "${fld:type}" ){	// 记次卡
	document.formEditor.shengyutianshu.value ="${fld:i_count}";
	document.getElementById("shengyutianshu_span").innerHTML ="剩余次数";
}else{
	document.formEditor.shengyutianshu.value ="${fld:shengyutianshu}";
	document.getElementById("shengyutianshu_span").innerHTML ="剩余天数";
}
$("#startenddate").html("${fld:in_c_startdate}至${fld:in_c_enddate}");
document.formEditor.vc_remark.value = "${fld:vc_remark@js}";
document.formEditor.vc_cardtype.value = "${fld:in_vc_cardtype}";
document.formEditor.in_bianhao.value = "${fld:in_bianhao}";
document.formEditor.in_vc_cardtype.value = "${fld:in_vc_cardtype}";
document.formEditor.in_i_totalday.value = "${fld:in_i_totalday}";
document.formEditor.in_i_giveday.value = "${fld:in_i_giveday}";
document.formEditor.in_f_factmoney.value = "${fld:in_f_factmoney}";
document.formEditor.in_c_savestartdate.value = "${fld:in_c_savestartdate}";
document.formEditor.in_i_count.value = "${fld:in_i_count}";
document.formEditor.in_f_money.value = "${fld:in_f_money}";
document.formEditor.in_vc_passwd.value = "${fld:in_vc_passwd@js}";
document.formEditor.in_c_mdate.value = "${fld:in_c_mdate}";
document.formEditor.in_i_savedays.value = "${fld:in_i_savedays}";
document.formEditor.in_f_moneyleft.value = "${fld:in_f_moneyleft}";
document.formEditor.in_vc_remark.value = "${fld:in_vc_remark@js}";
document.formEditor.in_vc_comabr.value = "${fld:in_vc_comabr}";
document.formEditor.in_i_nowcount.value = "${fld:in_i_nowcount}";
document.formEditor.in_f_continuecardfee.value = "${fld:in_f_continuecardfee}";
document.formEditor.in_vc_contractcode.value = "${fld:in_vc_contractcode@js}";
document.formEditor.in_f_liliaomoney.value = "${fld:in_f_liliaomoney}";
document.formEditor.in_i_xiyucount.value = "${fld:in_i_xiyucount}";
document.formEditor.in_c_startdate.value = "${fld:in_c_startdate}";
document.formEditor.in_c_enddate.value = "${fld:in_c_enddate}";
document.formEditor.vc_club.value = "${fld:vc_club}";
b++
document.formEditor.b.value = b;
</rows>

<search-list>
document.formEditor.vc_code.value = "${fld:code@js}";
document.formEditor.i_status.value = "${fld:i_status@js}";
document.formEditor.vc_name.value = "${fld:name@js}";
document.formEditor.i_sex.value = "${fld:sex}";
document.formEditor.vc_club.value = "${fld:org_id}";
ccms.util.setCheckboxValue('vc_club',"${fld:fullname@js}","formEditor");
document.formEditor.c_birthdate.value = "${fld:birthdate}";
document.formEditor.vc_rank.value = "${fld:rank@js}";
document.formEditor.vc_email.value = "${fld:email@js}";
document.formEditor.vc_idnumber.value = "${fld:idnumber@js}";
document.formEditor.vc_nation.value = "${fld:nation@js}";
document.formEditor.vc_hometel.value = "${fld:hometel@js}";
document.formEditor.vc_addr.value = "${fld:addr@js}";
document.formEditor.vc_officetel.value = "${fld:officetel@js}";
document.formEditor.vc_zip.value = "${fld:zip@js}";
document.formEditor.vc_mobile.value = "${fld:mobile@js}";
document.formEditor.vc_contact.value = "${fld:contact@js}";
document.formEditor.vc_company.value = "${fld:company@js}";
document.formEditor.vc_jobtype.value = "${fld:jobtype@js}";
document.formEditor.vc_illnessrec.value = "${fld:illnessrec@js}";
document.formEditor.vc_hobby.value = "${fld:hobby@js}";
document.formEditor.vc_pt.value = "${fld:pt@js}";
document.formEditor.vc_mc.value = "${fld:mc@js}";
document.formEditor.vc_hiddencustomercode.value = "${fld:guestcode@js}";
document.formEditor.f_moneyleft.value = "${fld:moneyleft}";
document.formEditor.vc_emcontact1.value = "${fld:emcontact1}";
document.formEditor.vc_emcontact2.value = "${fld:emcontact2@js}";
document.formEditor.vc_iuser.value = "${fld:iuser}";
document.formEditor.c_idate.value = "${fld:idate}";
document.formEditor.vc_remark.value = "${fld:remark@js}";
</search-list>

<pic-rows>
$("#tdPic").empty();
$("#tdPic").append('<img style="width:210px;height:310px;" src="${def:context}/action/ccms/attachment/download?id=${fld:upload_id}&&type=1">');
</pic-rows>

$("#cardlist").empty();
<card-rows>
	var cardstr = '<tr class="card_record" code="${fld:cardcode}">';
	cardstr += '<td nowrap>${fld:cardcode}</td>';
	cardstr += '<td nowrap>${fld:cardtypename}</td>';
	cardstr += '<td nowrap>${fld:i_statusname}</td>';
	cardstr += '</tr>';
	$("#cardlist").append(cardstr);
</card-rows>
bindingCardFunc();


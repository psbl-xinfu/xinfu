//clearForm("formEditor");
document.formEditor.customer_code_input.value = "${fld:name@js}";
document.formEditor.customer_code.value = "${fld:customercode@js}";


$(".fbtype_item").eq("${fld:fbtype}").iCheck('check');//客诉类型
if("${fld:fbtype}"=="1")
{
	$("#complainttype").find("option").attr('selected',false); //解除默认
	setSelectValue($("#complainttype"), "${fld:complainttype}");
	switch('${fld:complainttype}')
	{
		case '1':
			$('.complaint_type_item').css('display','none');
			$('.my_li.complaint_userid').css('display','block');
			$("#complaint_userid").find("option").attr('selected',false); //解除默认
			setSelectValue($("#complaint_userid"), "${fld:complaint_userid}");
			break;
		case '2':
			$('.complaint_type_item').css('display','none');
			$('.my_li.complaint_skill').css('display','block');
			$("#complaint_skill").find("option").attr('selected',false); //解除默认
			setSelectValue($("#complaint_skill"), "${fld:complaint_skill}");
			break;
		case '3':
			$('.complaint_type_item').css('display','none');
			$('.my_li.complaint_item').css('display','block');
			$("#complaint_item").find("option").attr('selected',false);  //解除默认
			setSelectValue($("#complaint_item"), "${fld:complaint_item}");
			break;
		case '4':
			$('.complaint_type_item').css('display','none');
			$('.my_li.complaint_envir').css('display','block');
			$("#complaint_envir").find("option").attr('selected',false);
			setSelectValue($("#complaint_envir"), "${fld:complaint_envir}");
			break;
	}
}
$("#complaint_item,#complainttype,#complaint_envir").selectpicker("refresh");
$("#complaint_item,#complainttype,#complaint_envir").selectpicker("render");


if("${fld:isanonymous}"=="1") //如果匿名
{
	$('.input_customer_name').css('display','none');
    $('#isanonymous').val(1);
	$('#isanonymous_checkbox').iCheck('check');
}
else{
	 $('#isanonymous').val(0);
}

$('#formEditor').find('#fbremark').val("${fld:fbremark@js}"); //意见
if("${fld:status}"=="2"||"${fld:status}"=="3"||"${fld:status}"=="4"){
	$("#resultremark").show();
}

$('#formEditor').find('#remark').val("客服：${fld:actualfollowstaff@js}\n处理时间：${fld:updated}\n处理结果：${fld:remark@js}"); //处理结果


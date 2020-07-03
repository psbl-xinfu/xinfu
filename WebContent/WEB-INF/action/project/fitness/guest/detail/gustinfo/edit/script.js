document.addForm.cc_code.value="${fld:code@js}";
document.addForm.company.value="${fld:officename}";//公司名称
$("#guestnum").val("${fld:guestnum}");//公司数量
setSelectValue($("#cc_birthall"), "${fld:customtype}");//公司类型
setSelectValue($("#cc_birthall"), "${fld:possibility}");//可能性
setSelectValue($("#communicationall"), "${fld:communication}");//客户分类
setSelectValue($("#custcationsall"), "${fld:custclass}");//客户详细分类（已购产品）
setSelectValue($("#cc_channelall"), "${fld:channel}");//获客渠道
$("#cc_officetel").val("${fld:othertel}");//电话
$("#thepublicall").val("${fld:thepublic}");//公众号
$("#cc_email").val("${fld:email}");//email
var possibility_id='${fld:possibility}';
var arrlists=possibility_id.split(",");

$('#possibility').selectpicker('val', arrlists);
$("#possibility4").val("${fld:possibility}");

setSelectValue($("#province2"), "${fld:province2}");
/*setSelectValue($("#city2"), "${fld:city2}");*/
getSelectDomain("city2", "City", "Province", "${fld:province2}",function(){
 	setSelectValue($("#city2"), "${fld:city2}");
});



setSelectValue($("#cc_mc"), "${fld:mc}");


	var communication=$("#communicationall").val();
	if(communication==''){
		$('#businesstype1').hide();
		setSelectValue($("#custcation"), "");
	}else{
		if(communication==2){
			$('#businesstype1').show();
			/*selectpicker($("#custcations"), );*/
			var select_id='${fld:custclass}';
			 var arr=select_id.split(",");
			/* $('#custcations').val(arr).trigger('change');*/
			/*$("#custcations").val('${fld:custclass}');*/
			$('#custcationsall').selectpicker('val', arr);
			$("#custcation").val("${fld:custclass}");
		}else{
			$('#businesstype1').hide();
			setSelectValue($("#custcationsall"), "");
		}
	}


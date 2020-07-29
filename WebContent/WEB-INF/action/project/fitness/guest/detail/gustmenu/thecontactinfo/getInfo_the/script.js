var guestcode="";
<rows>
	guestcode="${fld:guestcode}";
$('#officename').text("${fld:officename}");
$('#guestnum').text("${fld:guestnum}");
$('#officetel').text("${fld:othertel}");
$('#thepublic').text("${fld:thepublic}");
/*if("${fld:birth}"!=''&&"${fld:birthday}"!=''){
	$('#birth').text("${fld:birth}月${fld:birthday}日");
}*/
$('#province1').text("${fld:city}"+"${fld:province}");
$('#email').text("${fld:email}");
$('#mc').text("${fld:mc}");
$('#cc_birth').text("${fld:customtype2}");
$('#cc_channel').text("${fld:channel2}");

$('#communication').text("${fld:communication2}");

var custclass="${fld:custclass}";
var arr=custclass.split(",");
/* var custcationsarry =custclass.split(",").length ;*/
 var custcations="";
 <product-rows>
 	for (var i = 0; i < arr.length; i++) {
		if(arr[i]=="${fld:procode}"){
			custcations+="${fld:proname};";
		}
		
	}
 </product-rows>

$('#custcations').text(custcations.substr(0, custcations.length - 1) );
$('#remark').text("${fld:remark}");
//-----

document.addForm.cc_code.value="${fld:code@js}";
document.addForm.company.value="${fld:officename}";//公司名称
$("#guestnum").val("${fld:guestnum}");//公司数量
setSelectValue($("#cc_birthall"), "${fld:customtype}");
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
		if(communication=='2'){
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


</rows>
var branchnum=0;

<branch-rows>
	/*<input type="hidden" name="menuorgid" id="menuorgid" value="${fld:menuorgid}" />
*/	if("${fld:states}"==0){
		branchstr+='<span class="lable3">主店名称：</span>';
		branchstr+='<span class="lable4" id="storename">${fld:storename}</span>';
		branchstr+='<span class="lable3">主店地址：</span>';
		branchstr+='<span class="lable4" id="address">${fld:address}</span>';
	}else{
		branchstr +='<span class="lable3">分店名称:</span>' ;
		branchstr +='<span class="lable4" id="storename">${fld:storename}</span>';
		branchstr +='<span class="lable3">分店地址:</span>';
		branchstr +='<span class="lable4" id="address">${fld:address}</span>';
		
	}
</branch-rows>


$("#branch").append(branchstr); 




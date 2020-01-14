document.addForm.cc_code.value="${fld:code@js}";
document.addForm.company.value="${fld:officename}";

document.addForm.cc_officetel.value="${fld:officetel@js}"; 
document.addForm.cc_email.value="${fld:email}";
document.addForm.address.value="${fld:officeaddr}";
document.addForm.postalcode.value="${fld:postcode}";
document.addForm.cc_remark.value="${fld:remark}";

/*<labelguest-row>
	ccms.util.setCheckboxValue("labels", "${fld:labelguestcode}", "addForm");
</labelguest-row>*/

setSelectValue($("#province2"), "${fld:province2}");
/*setSelectValue($("#city2"), "${fld:city2}");*/
getSelectDomain("city2", "City", "Province", "${fld:province2}",function(){
 	setSelectValue($("#city2"), "${fld:city2}");
});

setSelectValue($("#cc_mc"), "${fld:mc}");


$("#yttcode").val("${fld:yttcode}");

setSelectValue($("#communication"), "${fld:communication}");
	var communication=$("#communication").val();
	if(communication==''){
		$('#businesstype1').hide();
		setSelectValue($("#custcation"), "");
	}else{
		if(communication==1){
			$('#businesstype1').show();
			/*selectpicker($("#custcations"), );*/
			var select_id='${fld:custclass}';
			 var arr=select_id.split(",");
			/* $('#custcations').val(arr).trigger('change');*/
			/*$("#custcations").val('${fld:custclass}');*/
			$('#custcations').selectpicker('val', arr);
			$("#custcation").val("${fld:custclass}");
		}else{
			$('#businesstype1').hide();
			setSelectValue($("#custcations"), "");
		}
	}
	
var ptstr = "<option value=''>请选择</option>";

<thecontact-row>
	ptstr+="<option value='${fld:ttcode@js}'>${fld:ttname}</option>"
</thecontact-row>
	
$("#ttname").html(ptstr);

var binstatus
<thecontactstrat-row>
setSelectValue($("#ttname"), "${fld:ttcodestrat}");
 binstatus="${fld:ttstatus}";
</thecontactstrat-row>

if(binstatus==1){
	setSelectValue($("#ttstatus"), "1");
}
setSelectValue($("#cc_birth"), "${fld:customtype}");
$("#guestnum").val("${fld:guestnum}");
//修改id号  zyb 2019-3-21
$("#ttname").selectpicker("refresh");
$("#ttname").selectpicker("render");

 



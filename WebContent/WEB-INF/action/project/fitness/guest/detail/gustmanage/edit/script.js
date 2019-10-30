document.addForm.cc_code.value="${fld:code@js}";
document.addForm.company.value="${fld:officename}";

document.addForm.cc_officetel.value="${fld:officetel@js}"; 
document.addForm.cc_email.value="${fld:email}";
document.addForm.address.value="${fld:officeaddr}";
document.addForm.postalcode.value="${fld:postcode}";
document.addForm.cc_remark.value="${fld:remark}";

<labelguest-row>
	ccms.util.setCheckboxValue("labels", "${fld:labelguestcode}", "addForm");
</labelguest-row>

setSelectValue($("#province2"), "${fld:province2}");
/*setSelectValue($("#city2"), "${fld:city2}");*/
getSelectDomain("city2", "City", "Province", "${fld:province2}",function(){
 	setSelectValue($("#city2"), "${fld:city2}");
});

setSelectValue($("#cc_mc"), "${fld:mc}");


$("#yttcode").val("${fld:yttcode}");

setSelectValue($("#cc_birth"), "${fld:customtype}");

var ptstr = "<option value=''>请选择</option>";

<thecontact-row>
	ptstr+="<option value='${fld:ttcode@js}'>${fld:ttname}</option>"
</thecontact-row>
	
$("#ttname").html(ptstr);



//修改id号  zyb 2019-3-21
$("#ttname").selectpicker("refresh");
$("#ttname").selectpicker("render");

 



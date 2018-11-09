
$("#hccode").val("${fld:code}");
$("#hcsiteusedetail").html("${fld:sitename}-${fld:prepare_date@yyyy-MM-dd}"
		+" ${fld:prepare_starttime}-${fld:prepare_endtime}");

$("#cddatagridTemplate").html("<tr><td>${fld:customertype}</td><td>${fld:name}</td><td>${fld:mobile}</td></tr>");




var hcsitedef = "<option value=''>请选择</option>";
//场地类型相同场地
<sitedef-rows>
	hcsitedef += "<option value='${fld:sitedefcode}'>${fld:stname@js}</option>";
</sitedef-rows>
$("#hcsitedef").html(hcsitedef);
$("#hcsitedef").selectpicker("refresh");
$("#hcsitedef").selectpicker("render");
setSelectValue($("#guestgroup"), "");





var ptstr = "<option value=''>请选择</option>";
<cabinetcode-rows>
	ptstr+="<option code='${fld:cabinetcode@js}' price='${fld:price@js}' value='${fld:tuid}'>${fld:cabinetcode@js}</option>"
</cabinetcode-rows>
$("#cabinet_code_id").html(ptstr);

$("#cabinet_code_id").selectpicker("refresh");
$("#cabinet_code_id").selectpicker("render");

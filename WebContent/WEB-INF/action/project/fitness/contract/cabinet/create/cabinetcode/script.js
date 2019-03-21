var ptstr = "<option value=''>请选择</option>";
<cabinetcode-rows>
	ptstr+="<option code='${fld:cabinetcode@js}' price='${fld:price}' value='${fld:tuid}'>${fld:cabinetcode@js}</option>"
</cabinetcode-rows>
//修改select id号  zyb 2019-3-21
$("#cabinetid").html(ptstr);
//修改id号  zyb 2019-3-21
$("#cabinetid").selectpicker("refresh");
$("#cabinetid").selectpicker("render");

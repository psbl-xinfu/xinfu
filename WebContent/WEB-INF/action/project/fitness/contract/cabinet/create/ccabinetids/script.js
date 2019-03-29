
var ptstr = "<option value=''>请选择</option>";

<cabinetcodes-rows>
	ptstr+="<option code='${fld:cabinetcode@js}' price='${fld:price}' value='${fld:tuid}'>${fld:cabinetcode@js}</option>"
</cabinetcodes-rows>
	
$("#cabinetid").html(ptstr);
//修改select id号  zyb 2019-3-21
$("#cabinetid").selectpicker("val", "${fld:tuids}");

//修改id号  zyb 2019-3-21
$("#cabinetid").selectpicker("refresh");
$("#cabinetid").selectpicker("render");


var guestgroup = "<option value=''>请选择</option>";
<rows>
	guestgroup+="<option value='${fld:ggtuid}'>${fld:groupname@js}</option>";
</rows>
$("#guestgroup").html(guestgroup);
$("#guestgroup").selectpicker("refresh");
$("#guestgroup").selectpicker("render");

setSelectValue($("#guestgroup"), "${fld:tuid}");
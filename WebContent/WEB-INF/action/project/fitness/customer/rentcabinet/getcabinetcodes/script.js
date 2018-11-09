var str=""
<rows>
str+='<option  code="${fld:tuid}"  value="${fld:cabinetcode@js}">${fld:cabinetcode@js}</option>'
</rows>
$('#c_newcabinetcode').html(str);
$('#c_newcabinetcode').selectpicker("refresh");
$('#c_newcabinetcode').selectpicker("render");

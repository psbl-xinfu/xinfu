﻿document.formEditor.cnfg_id.value = "${fld:cnfg_id}";
document.formEditor.dev_deviceid.value = "${fld:deviceid}";
document.formEditor.dev_appid.value = "${fld:appid}";
document.formEditor.dev_type.value = "${fld:type}";
document.formEditor.dev_remark.value = "${fld:remark}";

$("#dev_status").selectpicker("val","${fld:status}");
$("#dev_status").selectpicker("refresh");//刷新
$("#dev_status").selectpicker("render");


var _pobj = $("#${fld:objid}");
_pobj.empty();
_pobj.append('<option code="" value="">请选择支付方式</optioin>');
<paytype-rows>
_pobj.append('<option code="0" value="${fld:param_value@js}">${fld:param_text@js}</optioin>');
</paytype-rows>

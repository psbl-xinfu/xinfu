var str='<option value="">请选择市</option>' ;
<domain-rows>
	str+='<option value="${fld:domain_value}">${fld:domain_text_cn}</option>';
</domain-rows>

$("#city2").html(str);
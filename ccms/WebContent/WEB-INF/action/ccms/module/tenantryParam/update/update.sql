UPDATE
    t_tenantry_domain
SET
	 domain_value = ${fld:domain_value}    
	, domain_text_cn = ${fld:domain_text_cn}    
	, domain_text_en = ${fld:domain_text_en}    
	, is_default = ${fld:is_default}    
	, namespace = ${fld:namespace}    
	, parent_namespace = ${fld:parent_namespace}    
	, parent_domain_value = ${fld:parent_domain_value}    
	, remark = ${fld:remark}
	, show_order = ${fld:show_order}
	, updated = {ts '${def:timestamp}'}
	, updatedby = '${def:user}'
WHERE
	tuid	=${fld:tuid}

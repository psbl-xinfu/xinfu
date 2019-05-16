select 
	cf.param_value,
	cf.param_text
from cc_config cf 
where cf.category = 'sitetype' 
and cf.org_id =${fld:org_id}
and cf.param_value in (select sitetype::varchar from cc_sitedef where org_id = ${fld:org_id})
	
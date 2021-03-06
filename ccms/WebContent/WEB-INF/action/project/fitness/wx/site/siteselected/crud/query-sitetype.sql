select 
	cf.param_text as sitetypetext
from cc_config cf 
where cf.category = 'sitetype' 
and cf.org_id = (case when 
		not exists(select 1 from cc_config c where c.org_id = ${fld:org_id} and c.category=cf.category) 
		then (select org_id from hr_org where pid is null or pid = 0) 
		else ${fld:org_id} end)
and cf.param_value = ${fld:sitetype}
	
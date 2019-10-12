select 
	t.tuid as logoimgid
from t_attachment_files t 
where t.pk_value = '${def:org}' 
and t.table_code = 'hr_org_small' and t.org_id= ${def:org} 
order by t.tuid desc 
limit 1
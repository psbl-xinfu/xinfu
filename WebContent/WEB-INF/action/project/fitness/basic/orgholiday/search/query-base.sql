select 
	la.code,
	la.name,
	la.createdby,
	la.created
from cc_label la
where la.org_id = ${def:org} 
order by code desc
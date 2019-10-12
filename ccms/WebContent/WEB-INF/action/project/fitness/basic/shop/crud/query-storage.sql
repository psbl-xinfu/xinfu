select 
	tuid,
	storage_name
from cc_storage 
where status = 1 and org_id = ${def:org}
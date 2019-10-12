select 
	(select storage_name from cc_storage where tuid = storageid and org_id = ${def:org}) as storage_name,
	enter_date,
	status
from cc_enter_stock 
where org_id = ${def:org} and tuid = ${fld:enterstockid}


select
	concat('<input type="checkbox" name="storagelist" value="', tuid, '" "/>') AS checklink,
	storage_name,
	address,
	(case status when 1 then '已启用' when 0 then '已禁用' else '' end) status
from cc_storage
where org_id = ${def:org}
${filter}
${orderby}



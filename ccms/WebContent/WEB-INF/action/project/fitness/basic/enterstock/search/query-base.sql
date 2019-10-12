select
	concat('<input type="checkbox" name="enterstocklist" value="', tuid, '" code1="', storageid,'" code= "', status,'"/>') AS checklink,
	(select storage_name from cc_storage where tuid = storageid and org_id = ${def:org}) as storage_name,
	enter_date,
	normalmoney,
	factmoney,
	(case when status=1 then '未入库' when status=2 then '已入库' else '无效' end) as status,
	(case when updated is null then created else updated end) as created
from cc_enter_stock
where org_id = ${def:org} and status !=0
${filter}
${orderby}



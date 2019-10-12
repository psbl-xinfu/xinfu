select 
	tuid,
	goods_name
from cc_goods
where status = 1 and org_id = ${def:org}


select 
	code,
	sitename,
	block_price,--包场价格（元/小时）
	block_maxnum,--包场最大人数
	group_price,--拼场价格（元/小时）
	group_minnum,--拼场最小人数
	group_maxnum,--拼场最大人数
	opening_date,--开场时间
	closed_date--闭场时间
from cc_sitedef
where code=${fld:code} and org_id = ${def:org}


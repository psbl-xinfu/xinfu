select 
	code,
	sitename,
	block_price,--包场价格（元/小时）
	block_maxnum,--包场最大人数
	group_price,--拼场价格（元/小时）
	group_minnum,--拼场最小人数
	group_maxnum,--拼场最大人数
	org_id
from cc_sitedef
where status = 1 and org_id = ${fld:org_id}
and sitetype = ${fld:sitetype}
order by created desc
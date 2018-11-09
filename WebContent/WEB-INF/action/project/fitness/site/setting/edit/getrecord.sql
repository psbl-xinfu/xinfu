select
	code,
	sitename,
	sitetype,
	opening_date,
	closed_date,
	block_price,
	block_maxnum,
	group_price,
	group_minnum,
	group_maxnum,
	remark
from
	cc_sitedef
where
	code=${fld:code} and org_id = ${def:org}

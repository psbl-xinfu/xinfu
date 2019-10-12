insert into cc_public(
	tuid
	,datatype
	,customercode
	,entertime
	,oldfollow
	,newfollow
	,reason
	,status
	,grabtime
	,org_id
) 
select 
	nextval('seq_cc_public'),
	2,
	c.code,
	{ts '${def:timestamp}'},
	c.mc,
	c.mc,
	'成为会员添加public中',
	1,
	{ts '${def:timestamp}'},
	c.org_id
from cc_customer c
where c.code=(SELECT t.customercode FROM cc_contract t 
	WHERE t.code = ${fld:contractcode} AND t.org_id = ${def:org} LIMIT 1)
	and c.org_id=${def:org}
	and not EXISTS(select 1 from cc_public where customercode=c.code and org_id=c.org_id)

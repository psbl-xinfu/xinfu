insert into cc_ptrest_replace
(
	code,
	customercode,
	ylptrestcode,
	xzptrestcode,
	replacecount,
	ptmoney,
	ptfee,
	ptid,
	createdby,
	created,
	org_id,
	remark
)
SELECT 
	nextval('seq_cc_ptrest_replace')
	,customercode
	,code
	,${seq:currval@seq_cc_ptrest}
	,${fld:ptleftcount}
	,${fld:ghfee}::float
	,${fld:xzptfeedj}::float
	,ptid
	,'${def:user}'
	,{ts'${def:timestamp}'}
	,org_id
	,${fld:remark}
	
from cc_ptrest 
where code = ${fld:code} and org_id = ${def:org}
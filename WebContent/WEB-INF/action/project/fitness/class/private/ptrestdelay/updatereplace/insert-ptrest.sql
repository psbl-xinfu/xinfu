INSERT INTO cc_ptrest(
	code
	,customercode
	,ptlevelcode
	,pttotalcount
	,ptleftcount
	,ptnormalmoney
	,ptmoney
	,ptfactfee
	,ptfee
	,scale
	,ptid
	,createdby
	,created
	,pttype
	,ptenddate
	,org_id
) 
SELECT 
	nextval('seq_cc_ptrest')
	,customercode
	,${fld:ptdefcode}
	,${fld:ptleftcount}
	,${fld:ptleftcount}
	,${fld:ghfee}::float
	,${fld:ghfee}::float
	,${fld:xzptfeedj}::float
	,${fld:xzptfeedj}::float
	,0
	,ptid
	,'${def:user}'
	,{ts'${def:timestamp}'}
	,6
	,ptenddate
	,org_id
from cc_ptrest 
where code = ${fld:code} and org_id = ${def:org}
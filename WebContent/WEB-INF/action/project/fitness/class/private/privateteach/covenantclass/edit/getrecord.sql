select
	code,
	ptid,
	ptrestcode,
	cardcode,
	customercode,
	preparedate,
	preparetime
from 
	cc_ptprepare 	
where 
	code = ${fld:id} and org_id = ${def:org}

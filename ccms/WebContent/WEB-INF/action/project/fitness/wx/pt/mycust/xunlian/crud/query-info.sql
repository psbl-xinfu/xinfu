select
2 as num,
created,
	(select  ptlevelname  from cc_ptdef where org_id = ${def:org} and code=
		(select ptlevelcode from cc_ptrest where org_id = ${def:org} and code=
			(select ptrestcode from cc_ptprepare where code=ptpreparecode and org_id=${def:org}))
)as ptlevelname,
status
from 
cc_trainplan
where code=${fld:traincode}





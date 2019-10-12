select
code,
ptpreparecode,

(case when ptpreparecode is not null 
	then    
		(
		select name from hr_staff where userlogin=
			(select ptid from cc_ptprepare where code=ptpreparecode and org_id=${def:org})and org_id=${def:org}
		)
	end
)as ptname,


(case when ptpreparecode is not null 
	then    
	(select  ptlevelname  from cc_ptdef where code=
		(select ptlevelcode from cc_ptrest where code=
			(select ptrestcode from cc_ptprepare where code=ptpreparecode and org_id=${def:org}) and org_id=${def:org})
	and org_id=${def:org})
	end
)as ptlevelname,

(case when ptpreparecode   is not null 
	then    
	(select  ptfee  from cc_ptdef where code=
		(select ptlevelcode from cc_ptrest where code=
			(select ptrestcode from cc_ptprepare where code=ptpreparecode and org_id=${def:org})and org_id=${def:org})
	and org_id=${def:org})
	end
)as ptfee,

code,
created
from 
cc_testresult
where
(
customercode=${fld:customercode}
or
guestcode=(select guestcode from cc_customer where code =${fld:customercode} and org_id=${def:org})
)
and org_id=${def:org}
${filter}
order by created  desc





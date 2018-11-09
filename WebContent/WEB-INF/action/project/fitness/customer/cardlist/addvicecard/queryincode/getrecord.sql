select 
	count(1) as num
from cc_cardcode
where incode = ${fld:incode} and org_id = ${def:org}

   
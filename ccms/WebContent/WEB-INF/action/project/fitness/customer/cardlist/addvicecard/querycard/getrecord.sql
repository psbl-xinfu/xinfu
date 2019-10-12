select 
	count(1) as num
from cc_card
where code = ${fld:cardcode} and org_id = ${def:org}

   
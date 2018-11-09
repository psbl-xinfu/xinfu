select 
	code,
	name,
	mobile,
	sex,
	age,
	cardtype,
	card,
	urgent,
	othertel
from cc_customer
where mobile = ${fld:mobile} and org_id = ${def:org}
limit 1
   
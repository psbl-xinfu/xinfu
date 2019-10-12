select 
	max(enddate)-(case when min(startdate)::date<'${def:date}'::date 
		then '${def:date}'::date else min(startdate) end) as days
from cc_card
where customercode = ${fld:custcode} and isgoon = 0 and status!=0

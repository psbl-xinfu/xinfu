select 
	count(1) as inlefthbnum
from cc_inleft
where itemtype = 0 and customercode = ${fld:custcode}
and indate>(select '${def:date}'::date-60) and indate<=(select '${def:date}'::date-30)


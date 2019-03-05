select 
	count(1) as inleftnum
from cc_inleft
where itemtype = 0 and customercode = ${fld:custcode}
and indate>(select '${def:date}'::date-30) and indate<='${def:date}'::date


select 
	concat('${def:date} ', (sum((case when lefttime is null then concat(indate, ' 23:59:59')::timestamp 
		else lefttime end)-intime)/count(1)))::timestamp as times
from cc_inleft
where itemtype = 0 and customercode = ${fld:custcode}
 and indate>${fld:inleftfdate}
and lefttime is not null



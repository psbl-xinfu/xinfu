select 
	indate as createdate,
	count(1) as num
from cc_inleft
where itemtype = 0 and customercode = ${fld:custcode}
and indate>${fld:fdate} and indate<=${fld:tdate}
GROUP BY indate order by indate asc


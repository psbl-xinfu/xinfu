select	
	weekday,
	to_char(starttime1, 'HH24:mi') as starttime1,
	to_char(endtime1, 'HH24:mi') as endtime1
from cc_cardtype_timelimit 
where
cardtype= ${fld:id}  and org_id=${def:org}

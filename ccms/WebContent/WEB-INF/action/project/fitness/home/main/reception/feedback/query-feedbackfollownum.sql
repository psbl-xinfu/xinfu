select 
	count(1) as todaynum 
from cc_feedback_follow 
where org_id = ${def:org} and status!=0
and followstaff = '${def:user}'
and created::date = '${def:date}'::date 


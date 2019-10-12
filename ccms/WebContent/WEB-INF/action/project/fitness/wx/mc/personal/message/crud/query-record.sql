
select 

	(SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE user_id =(select user_id from cc_customer where code=msg.ren and org_id = ${def:org})
		 )as headpic,
		 
		 
	(select name from cc_customer where code=msg.ren and org_id = ${def:org}) as name,
	msg.ren,
	m.sendtime,
	m.content
from cc_message m
INNER JOIN 
(select ren,max(tuid) as tuid from (select 
	recuser as ren,
	max(tuid) as tuid
from cc_message m
where (senduser='${def:user}' or recuser='${def:user}')
and issystem=0 and org_id = ${def:org}
GROUP BY recuser
union

select 
	senduser as ren,
	max(tuid) as tuid
from cc_message m
where (senduser='${def:user}' or recuser='${def:user}')
and issystem=0 and org_id = ${def:org}
GROUP BY senduser) as d where ren!='${def:user}' GROUP BY ren) as msg
on msg.tuid = m.tuid
order by m.tuid desc

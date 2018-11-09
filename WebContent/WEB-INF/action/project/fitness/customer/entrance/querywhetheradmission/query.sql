
select 
	weekday,
	to_char(starttime1, 'hh24:mi') as starttime1,
	to_char(endtime1, 'hh24:mi') as endtime1,
	to_char(starttime1, 'hh24mimm')::integer as starttime,
	to_char(endtime1, 'hh24mimm')::integer as endtime,
	to_char('${def:timestamp}'::time, 'hh24mimm')::integer as datetime
from cc_cardtype_timelimit 
where cardtype = ${fld:cardtype} and org_id = ${def:org}
--select 
--	weekday,
--	sum(case when starttime1::time<=to_char('2018-07-25 13:00:00'::timestamp, 'HH24:mi')::time
--				and endtime1::time>=to_char('2018-07-25 13:00:00'::timestamp, 'HH24:mi')::time
--				then 1 else 0
--	end) as num
--from cc_cardtype_timelimit
--where cardtype = ${fld:cardtype} and org_id = ${def:org}
--GROUP BY weekday
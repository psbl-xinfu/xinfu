insert into cc_cardtype_timelimit
(
	cardtype,
	weekday,
	org_id
)
select 
${seq:currval@seq_cc_cardtype},
iweek,
${def:org}
from (
select 
1  as iweek
union
select 
2 as iweek
union
select 
3 as iweek
union
select 
4 as iweek
union
select 
5 as iweek
union
select 
6 as iweek
union
select 
7 as iweek
)  a
select
	code as tuid,
	name,
	mobile,
	sex,
	intention,
	(SELECT domain_text_cn FROM t_domain WHERE namespace = 'Age' and domain_value = age::varchar) as age
from cc_guest
where status = 1 and org_id = ${def:org}
and (case when ${fld:name} is null then 1=1 
		else (name like concat('%', ${fld:name}, '%') or mobile like concat('%', ${fld:name}, '%')) end)
and (case when ${fld:startdate} is null then 1=1 else created::date>=${fld:startdate}::date end)
and (case when ${fld:enddate} is null then 1=1 else created::date<=${fld:enddate}::date end)
and (case when ${fld:intentions} is null then 1=1 
	else intention in (select regexp_split_to_table(${fld:intentions},',')) end)
and (case when ${fld:sexs} is null then 1=1 
	else sex::varchar in (select regexp_split_to_table(${fld:sexs},',')) end)
and (case when ${fld:ages} is null then 1=1 
	else age::varchar in (select regexp_split_to_table(${fld:ages},',')) end)
and (case when ${fld:communications} is null then 1=1 
	else communication in (select regexp_split_to_table(${fld:communications},',')) end)
--分组
and (case when ${fld:team_id} is null then 1=1 
	else createdby in (select userlogin from hr_team_staff where team_id in (select team_id from hr_team 
		where team_id::varchar in (select regexp_split_to_table(${fld:team_id},',')) and org_id = ${def:org})) end)
--组员
and (case when ${fld:userlogin} is null then 1=1 
	else createdby in (select regexp_split_to_table(${fld:userlogin},',')) end)

and (case when ${fld:usertype}='1' then 1=1
		 when ${fld:usertype}='2' then createdby 
		 	in (select userlogin from hr_team_staff where team_id = 
		 		(select team_id from hr_team where leader_id::int = 
		 		(select user_id from hr_staff where userlogin = '${def:user}' 
		 		and org_id = ${def:org}) and org_id = ${def:org}))
		 when ${fld:usertype}='3' then createdby = '${def:user}'
		else 1=2 end)
and (case when ${fld:demand} is null then 1=1 else EXISTS(
	select dem from (select regexp_split_to_table(${fld:demand},',') as dem from dual) as d
	WHERE cc_guest.demand like concat('%', d.dem, '%')
) end)
	
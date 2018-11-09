select 1 from hr_org_holiday
where org_id = ${def:org} and '${def:date}'::date >= begintime 
and '${def:date}'::date<= endtime and status = 1
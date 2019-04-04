select 1 from hr_org_holiday
where org_id = ${fld:unionorgid} and '${def:date}'::date >= begintime 
and '${def:date}'::date<= endtime and status = 1
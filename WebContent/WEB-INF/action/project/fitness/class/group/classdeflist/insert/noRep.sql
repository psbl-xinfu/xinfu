select 1 from hr_org_holiday
where org_id = ${def:org} and ${fld:classdate}::date >= begintime 
and ${fld:classdate}::date<= endtime and status = 1
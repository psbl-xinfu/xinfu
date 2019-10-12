select 1 from hr_org_holiday
where org_id = ${def:org} and ${fld:pdate}::date >= begintime 
and ${fld:pdate}::date<= endtime and status = 1
select 1 from hr_org_holiday
where org_id = ${def:org} and ${fld:preparedate}::date >= begintime 
and ${fld:preparedate}::date<= endtime and status = 1
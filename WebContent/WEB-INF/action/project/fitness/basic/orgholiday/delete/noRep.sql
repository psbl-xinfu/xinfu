select 1 from hr_org_holiday
where tuid = ${fld:id}
and org_id = ${def:org} and status!=2

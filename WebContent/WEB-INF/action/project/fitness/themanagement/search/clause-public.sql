 and 
 (case when ${fld:public}=1 then
 now()::date-p.grabtime::date > ${fld:period_day}
 else 1=1 end)

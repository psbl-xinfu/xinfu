 and 
 (case when ${fld:public}=1 then (p.grabtime::date+(${fld:period_day}||'day')::interval)::date - now()::date < 0
 else 1=1 end)

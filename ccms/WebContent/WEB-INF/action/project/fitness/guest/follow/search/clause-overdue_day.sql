 and  (now()::date-(p.grabtime::date+(${fld:period_day}||'day')::interval)::date)>${fld:overdue_day}


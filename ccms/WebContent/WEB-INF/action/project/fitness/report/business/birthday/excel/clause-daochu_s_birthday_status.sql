 and 
    (case when ${fld:daochu_s_birthday_status}=0 then 
       extract (Week from '${def:date}'::date) =extract (Week from (concat(to_char('${def:date}'::date, 'yyyy'),'-',COALESCE(c.birth::integer,1),'-',COALESCE(c.birthday::integer,1)::varchar) ::Date))
    else c.birth=to_char('${def:date}'::date,'MM')::int4::varchar  end)
    
 and 
    (case when ${fld:s_birthday_status}=0 then 
       			extract (Week from '${def:date}'::date)
       				=extract (Week from (concat(to_char('${def:date}'::date, 'yyyy'),'-',COALESCE(c.birth::integer,1),'-',COALESCE( (case when (c.birth='2' and c.birthday::int > (select  (concat(to_char(date_trunc('year',current_date)::date, 'yyyy'),'-','03','-','01')::date - concat(to_char(date_trunc('year',current_date)::date, 'yyyy'),'-','02','-','01')::date)::int
)) then (select  (concat(to_char(date_trunc('year',current_date)::date, 'yyyy'),'-','03','-','01')::date - concat(to_char(date_trunc('year',current_date)::date, 'yyyy'),'-','02','-','01')::date)::varchar
) else c.birthday end)::integer,1)::varchar) ::Date))
		when ${fld:s_birthday_status}=1 then c.birth=to_char('${def:date}'::date,'MM')::int4::varchar  
    	when ${fld:s_birthday_status}=2 then concat(to_char('${def:date}'::date, 'yyyy'),'-',COALESCE(c.birth::integer,1),'-',COALESCE( (case when (c.birth='2' and c.birthday::int > (select  (concat(to_char(date_trunc('year',current_date)::date, 'yyyy'),'-','03','-','01')::date - concat(to_char(date_trunc('year',current_date)::date, 'yyyy'),'-','02','-','01')::date)::int
)) then (select  (concat(to_char(date_trunc('year',current_date)::date, 'yyyy'),'-','03','-','01')::date - concat(to_char(date_trunc('year',current_date)::date, 'yyyy'),'-','02','-','01')::date)::varchar
) else c.birthday end)::integer,1)::varchar)::date = '${def:date}'::date
    	when ${fld:s_birthday_status}=3 then c.birth::integer=(to_char('${def:date}'::date,'MM')::integer+1)
    end)
    
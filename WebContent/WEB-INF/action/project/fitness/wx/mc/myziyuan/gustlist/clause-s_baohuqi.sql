 and  
 (case when ${fld:s_baohuqi}::int>(select dayval from protectdey)::int
 	then 1=1 
 	else ('${def:date}'::date-p.grabtime::date)::int<=${fld:s_baohuqi}::int
 end)


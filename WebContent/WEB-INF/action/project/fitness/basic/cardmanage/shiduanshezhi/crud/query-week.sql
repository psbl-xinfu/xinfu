select 
   weekday as i_weekday, 
   case weekday 
   	when 1 then '星期天'
   	when 2 then '星期一'
   	when 3 then '星期二'
   	when 4 then '星期三'
   	when 5 then '星期四'
   	when 6 then '星期五'
   	when 7 then '星期六'
   	else '未知'
   	end as week_name
from 
   cc_cardtype_timelimit
 where 
 	cardtype = ${fld:in_vc_code} and org_id = ${def:org} 
 order by
 	weekday
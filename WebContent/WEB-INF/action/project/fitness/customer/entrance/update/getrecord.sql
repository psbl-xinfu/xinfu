select (case when lefttime is null then 1 else 2 end) as type
from cc_inleft 
where indate = (select current_date) 
and cardcode = ${fld:cardcode} and org_id = ${def:org}--${fld:unionorgid}
order by intime desc LIMIT 1
select 
	sum (case when enddate-startdate<0 then 0 else enddate-startdate end) as total_stopday
from cc_savestopcard  
where cardcode=${fld:cardname} and enddate is not null  and org_id = ${def:org}
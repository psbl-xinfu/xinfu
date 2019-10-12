select 
cabinettempcode as fttuid,
cardcode as ftcardcode,
(select status from cc_cabinettemp where tuid=${fld:cabinettempcode} and org_id=${def:org}) as ftstatus
from cc_inleft 
where indate = (select current_date) and 
cabinettempcode=${fld:cabinettempcode} and org_id=${def:org} 
and intime is not null and lefttime is null
order by intime desc limit 1  


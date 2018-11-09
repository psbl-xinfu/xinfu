 select
h.org_name,
i.address,
i.contact_phone
from
hr_org h
left join hr_org_info i on h.org_id=i.org_id
 where 
 h.org_id=${def:org}

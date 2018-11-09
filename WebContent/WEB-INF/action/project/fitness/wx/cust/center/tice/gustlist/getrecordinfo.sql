select
COALESCE(body_fat,0) as  body_fat,
COALESCE(weight,0)as weight,
COALESCE(lung_capacity,0)as lung_capacity,
COALESCE(weight_index,0)as weight_index ,
COALESCE(static_heart,0)as static_heart,
COALESCE(muscle,0) as muscle
from 
cc_testresult
where
guestcode=${fld:guestcode}
and org_id=${def:org}
order by created  desc
limit 1






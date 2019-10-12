select
COALESCE(body_fat,0) as  body_fat,
COALESCE(weight,0)as weight,
COALESCE(lung_capacity,0)as lung_capacity,
COALESCE(weight_index,0)as weight_index ,
COALESCE(static_heart,0)as static_heart,
COALESCE(muscle,0) as muscle
from 
cc_testresult
where (
customercode=${fld:customercode}
or
guestcode=(select guestcode from cc_customer where code =${fld:customercode})
) 
order by created  desc
limit 1






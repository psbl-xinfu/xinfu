select 
  distinct code,
  name as singname,
  (case when
  unit='0' then '次'
  when unit='1' then '张'
  else null
  end) as unit,
  price,
  fastcode
from 
   cc_singleitemdef
where status=1 and org_id =${def:org}
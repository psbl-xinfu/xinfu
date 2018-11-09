select
code,
created
from 
cc_testresult
where
guestcode=${fld:guestcode}
and org_id=${def:org}
order by created  desc





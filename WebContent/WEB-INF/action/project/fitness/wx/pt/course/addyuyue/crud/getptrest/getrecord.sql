select
count (*)  as num
from 
cc_ptprepare
WHERE 
customercode =  ${fld:customercode}

and
ptrestcode=${fld:ptrestcode}

and org_id =${def:org}
and 
(
status =1
or
status =4
)

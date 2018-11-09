select 1 
from cc_trainplan 
WHERE code in (select regexp_split_to_table(${fld:id},',') from dual)
and org_id = ${def:org} and status = 2

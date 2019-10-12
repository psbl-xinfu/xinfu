select 
  code as vc_code,
  ptlevelname as oper
from cc_ptdef
where org_id = ${def:org}
and status!=0
select
	code as huixian
from cc_singleitemdef
where 
	fastcode = ${fld:vc_fastcode} and org_id = ${def:org}

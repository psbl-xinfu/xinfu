select  distinct
	code as vc_code, 
	name as vc_name
from 
	cc_cardtype
where org_id = ${def:org}
select 
	the.code,
	the.guestcode
from cc_thecontact the
where the.org_id = ${def:org} and the.${field_name}='${field_value}'

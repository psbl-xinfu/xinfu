select 
	g.code,
	g.name 
from cc_label g
where g.org_id = ${def:org}

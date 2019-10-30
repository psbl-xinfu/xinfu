select 
	g.code as labelcode,
	g.name as labelname
from cc_label g
where g.org_id = ${def:org}

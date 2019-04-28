select 
	c.code
	,c.name
	,c.mobile 
from cc_guest c  
where c.status != 0 
and c.org_id = ${def:org} 
${filter}
select
	c.code
	,c.name
	,c.mobile 
	,c.org_id
from cc_customer c  
where c.status != 0 
${filter}
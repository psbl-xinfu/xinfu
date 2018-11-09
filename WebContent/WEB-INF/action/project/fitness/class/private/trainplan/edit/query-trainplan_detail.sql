select 
	td.code as tdcode
from cc_trainplan_detail td
where td.trainplancode = ${fld:code} and td.org_id = ${def:org}


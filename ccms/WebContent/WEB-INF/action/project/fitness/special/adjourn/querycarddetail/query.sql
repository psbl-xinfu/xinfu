select 
	startdate,
	enddate,
	status
from cc_card
where code = ${fld:code}
and org_id = ${def:org} and isgoon=0
select 
	tuid as exchange_tuid,
	showorder as exchange_showorder
from cc_report_subject
where showorder > ${fld:showorder} and category = ${fld:category}
and grade = ${fld:grade} and org_id = ${def:org}
and status=1
order by showorder asc limit 1

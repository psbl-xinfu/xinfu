select 
	report_month,
	sum(amonut) as amonut
from cc_report_monthly 
where report_year=${fld:date} and category=0
and org_id = ${def:org}
GROUP BY report_month
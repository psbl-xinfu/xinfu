select 
	report_month,
	report_subject_id,
	amonut
from cc_report_monthly
where report_year = ${fld:date}
and org_id = ${def:org}
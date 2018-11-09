select 
	sum((case when category=0 then amonut else 0 end)) as income,
	sum((case when category=1 then amonut else 0 end)) as spending
from cc_report_monthly rm
where 1=1
and (case when ${fld:startdate} is null then 1=1 else 
	concat(rm.report_year, '-', rm.report_month, '-01')::date>=concat(${fld:startdate}, '-01')::date end)
and (case when ${fld:enddate} is null then 1=1 else 
	concat(rm.report_year, '-', rm.report_month, '-01')::date<=concat(${fld:enddate}, '-01')::date end)
and (case when ${fld:org_id} is null then
	rm.org_id in (SELECT g.org_id FROM hr_org g WHERE g.org_id = ${def:org} 
	UNION 
	SELECT g.org_id FROM hr_org g 
		WHERE EXISTS(SELECT 1 FROM hr_staff_org so WHERE so.userlogin = '${def:user}' AND so.org_id = g.org_id)) 
else rm.org_id = ${fld:org_id} end)
	

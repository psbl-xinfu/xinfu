select
	(select name from hr_staff where userlogin = ptid) as name,
	count(1) as num
from cc_ptprepare
where status = 2 and org_id = ${def:org}
and to_char(preparedate, 'yyyy-MM') = ${fld:datemonth} 
group by ptid order by count(1) desc limit 4
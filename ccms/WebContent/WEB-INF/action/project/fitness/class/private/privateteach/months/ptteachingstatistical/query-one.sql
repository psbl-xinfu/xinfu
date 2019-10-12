select 
	preparedate::date AS createdate,
	count(1) AS num
from cc_ptprepare
where org_id = ${def:org} and status = 1
and to_char(preparedate, 'yyyy-MM') = to_char(${fld:fdate}::date, 'yyyy-MM')
GROUP BY preparedate::date,status


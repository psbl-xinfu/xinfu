SELECT 
	d.name,
	count(1) as num
from cc_singleitem s
inner join cc_singleitemdef d on s.itemcode = d.code and s.org_id = d.org_id
WHERE s.created::date >= ${fld:fdate} AND s.created::date <= ${fld:tdate} 
AND s.org_id = ${def:org} and s.status=2
GROUP BY d.code


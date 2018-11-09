select 
	iscttn,
	cttnnum,
	yeariscttn,
	yearcttnnum,
	monthiscttn,
	monthcttnnum
from 
(select 
	sum(case when cttn.iscttn = 1 then 1 else 0 end) as iscttn,
	count(1) as cttnnum
from
(SELECT 
	t.customercode,
	(
		CASE WHEN (
			SELECT p1.created::date FROM cc_ptrest p1 
			INNER JOIN cc_ptdef d1 ON d1.code = p1.ptlevelcode AND d1.org_id = p1.org_id 
			WHERE p1.customercode = t.customercode AND p1.org_id = t.org_id AND d1.reatetype != 1 
			ORDER BY p1.created OFFSET 1 LIMIT 1
		) BETWEEN ${fld:fdate} AND ${fld:tdate} THEN 1 ELSE 0 END
	) AS iscttn 
FROM (
	SELECT DISTINCT p.customercode, p.org_id  
	FROM cc_ptrest p 
	INNER JOIN cc_ptdef d ON d.code = p.ptlevelcode AND d.org_id = p.org_id 
	WHERE p.created::date <= ${fld:tdate} 
	AND d.reatetype != 1 AND p.org_id = ${def:org}
) AS t) as cttn) as t,
(select 
	sum(case when cttn.iscttn = 1 then 1 else 0 end) as yeariscttn,
	count(1) as yearcttnnum
from
(SELECT 
	t.customercode,
	(
		CASE WHEN (
			SELECT p1.created::date FROM cc_ptrest p1 
			INNER JOIN cc_ptdef d1 ON d1.code = p1.ptlevelcode AND d1.org_id = p1.org_id 
			WHERE p1.customercode = t.customercode AND p1.org_id = t.org_id AND d1.reatetype != 1 
			ORDER BY p1.created OFFSET 1 LIMIT 1
		) BETWEEN (${fld:fdate} - interval '1 year') AND (${fld:tdate} - interval '1 year') THEN 1 ELSE 0 END
	) AS iscttn 
FROM (
	SELECT DISTINCT p.customercode, p.org_id  
	FROM cc_ptrest p 
	INNER JOIN cc_ptdef d ON d.code = p.ptlevelcode AND d.org_id = p.org_id 
	WHERE p.created::date <= (${fld:tdate} - interval '1 year')
	AND d.reatetype != 1 AND p.org_id = ${def:org}
) AS t) as cttn) as t1,
(select 
	sum(case when cttn.iscttn = 1 then 1 else 0 end) as monthiscttn,
	count(1) as monthcttnnum
from
(SELECT 
	t.customercode,
	(
		CASE WHEN (
			SELECT p1.created::date FROM cc_ptrest p1 
			INNER JOIN cc_ptdef d1 ON d1.code = p1.ptlevelcode AND d1.org_id = p1.org_id 
			WHERE p1.customercode = t.customercode AND p1.org_id = t.org_id AND d1.reatetype != 1 
			ORDER BY p1.created OFFSET 1 LIMIT 1
		) BETWEEN (${fld:fdate} - interval '1 month') AND (${fld:tdate} - interval '1 month') THEN 1 ELSE 0 END
	) AS iscttn 
FROM (
	SELECT DISTINCT p.customercode, p.org_id  
	FROM cc_ptrest p 
	INNER JOIN cc_ptdef d ON d.code = p.ptlevelcode AND d.org_id = p.org_id 
	WHERE p.created::date <= (${fld:tdate} - interval '1 month') 
	AND d.reatetype != 1 AND p.org_id = ${def:org}
) AS t) as cttn) as t2
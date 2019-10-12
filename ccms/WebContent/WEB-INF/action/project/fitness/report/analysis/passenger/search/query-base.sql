SELECT 
	(
		CASE WHEN t1.createdate IS NOT NULL THEN t1.createdate 
		WHEN t2.createdate IS NOT NULL THEN t2.createdate 
		WHEN t3.createdate IS NOT NULL THEN t3.createdate 
		WHEN t4.createdate IS NOT NULL THEN t4.createdate 
		WHEN t5.createdate IS NOT NULL THEN t5.createdate 
		WHEN t6.createdate IS NOT NULL THEN t6.createdate 
		END
	) AS createdate
	,COALESCE(visitnum,0) AS visitnum
	,COALESCE(inleftnum,0) AS inleftnum
	,COALESCE(ptpreparenum,0) AS ptpreparenum
	,COALESCE(ptnum,0) AS ptnum
	,COALESCE(clspreparenum,0) AS clspreparenum
	,COALESCE(clsnum,0) AS clsnum 
FROM (
	/** 资源到访 */
	SELECT t.visitdate AS createdate, COUNT(1) AS visitnum 
	FROM cc_guest_visit t 
	WHERE t.visitdate >= ${fld:listfdate} AND t.visitdate <= ${fld:listtdate} 
	AND t.status != 0 AND t.org_id = ${def:org} 
	GROUP BY t.visitdate
) AS t1 
FULL JOIN (
	/** 会员入场 */
	SELECT t.intime::date AS createdate, COUNT(1) AS inleftnum 
	FROM cc_inleft t 
	WHERE t.intime::date >= ${fld:listfdate} AND t.intime::date <= ${fld:listtdate} 
	AND t.org_id = ${def:org} 
	GROUP BY t.intime::date
) AS t2 ON t1.createdate = t2.createdate 
FULL JOIN (
	/** 私教预约 */
	SELECT t.preparedate::date AS createdate, COUNT(1) AS ptpreparenum 
	FROM cc_ptprepare t 
	WHERE t.preparedate::date >= ${fld:listfdate} AND t.preparedate::date <= ${fld:listtdate} 
	AND t.status != 0 AND t.org_id = ${def:org}
	GROUP BY t.preparedate::date
) AS t3 ON t2.createdate = t3.createdate 
FULL JOIN (
	/** 私教签课 */
	SELECT t.created::date AS createdate, COUNT(1) AS ptnum 
	FROM cc_ptlog t 
	WHERE t.created::date >= ${fld:listfdate} AND t.created::date <= ${fld:listtdate} 
	AND t.status != 0 AND t.org_id = ${def:org}
	GROUP BY t.created::date
) AS t4 ON t3.createdate = t4.createdate 
FULL JOIN (
	/** 团操预约 */
	SELECT c.classdate AS createdate, COUNT(1) AS clspreparenum 
	FROM cc_classprepare t 
	INNER JOIN cc_classlist c ON t.classlistcode = c.code AND t.org_id = c.org_id 
	WHERE c.classdate >= ${fld:listfdate} AND c.classdate <= ${fld:listtdate} 
	AND t.status != 0 AND t.org_id = ${def:org}
	GROUP BY c.classdate
) AS t5 ON t4.createdate = t5.createdate 
FULL JOIN (
	/** 团操上课 */
	SELECT t.classdate AS createdate, SUM(COALESCE(t.personcount,0)) AS clsnum 
	FROM cc_classlist t 
	WHERE t.classdate >= ${fld:listfdate} AND t.classdate <= ${fld:listtdate} 
	AND t.status != 0 AND t.org_id = ${def:org} 
	GROUP BY t.classdate
) AS t6 ON t5.createdate = t6.createdate 
WHERE (
	(t1.visitnum IS NOT NULL AND t1.visitnum != 0) OR (t2.inleftnum IS NOT NULL AND t2.inleftnum != 0) 
	OR (t3.ptpreparenum IS NOT NULL AND t3.ptpreparenum != 0) OR (t4.ptnum IS NOT NULL AND t4.ptnum != 0) 
	OR (t5.clspreparenum IS NOT NULL AND t5.clspreparenum != 0) OR (t6.clsnum IS NOT NULL AND t6.clsnum != 0) 
) 
ORDER BY createdate
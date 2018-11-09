SELECT g.created::date AS createdate, COUNT(1) AS num 
FROM cc_ptlog g 
INNER JOIN cc_ptdef p ON p.code = g.ptlevelcode AND g.org_id = p.org_id 
WHERE to_char(g.created,'yyyy-MM') = to_char({ts '${def:timestamp}'},'yyyy-MM') 
AND g.ptid = '${def:user}' AND g.org_id = ${def:org} 
AND p.reatetype != 1 AND g.status != 0 
GROUP BY g.created::date

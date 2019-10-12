select tuid from t_term_score 
where term_id='1005' and relation_id=${fld:relation_id}
and org_id = ${def:org}
ORDER BY end_time desc limit 1

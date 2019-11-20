SELECT 
	domain_value,
	domain_text_cn 
FROM t_domain 
WHERE namespace = 'City' AND is_enabled = '1'  and parent_domain_value='${fld:province}'
ORDER BY domain_text_cn

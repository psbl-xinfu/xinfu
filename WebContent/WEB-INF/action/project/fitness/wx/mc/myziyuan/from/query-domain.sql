SELECT 
	domain_value,
	domain_text_cn 
FROM t_domain 
WHERE namespace = 'Province' AND is_enabled = '1' 
ORDER BY domain_text_cn

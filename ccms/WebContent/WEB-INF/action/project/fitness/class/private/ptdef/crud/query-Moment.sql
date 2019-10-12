SELECT 
	domain_value, 
	domain_text_cn 
FROM t_domain 
WHERE namespace = 'Moment' AND is_enabled = '1'

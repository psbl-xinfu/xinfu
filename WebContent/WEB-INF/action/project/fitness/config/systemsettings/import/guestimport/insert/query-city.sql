SELECT 
	domain_value
FROM t_domain  
WHERE namespace = 'City' AND is_enabled = '1' and ${field_text}='${field_value}'